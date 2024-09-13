require 'pagy/extras/jsonapi'

class UsersController < ApplicationController
    include Pagy::Backend

    skip_before_action :authenticate_user!, only: [:create]

    def create
        user = User.new user_params
        user.registered_at = Time.now

        token = encode_token user_id: user.id

        if user.save
            render json: { message: "User saved", user: user.as_json(only: [:name, :email, :id]), token: token}, status: 200
        else
            render json: { errors: { message: user.errors.full_messages}}
        end
    end

    def timeline
        user = User.find(params[:id])

        if user.github_username.present?
            github_user_public_events = Octokit.user_events user.github_username
            
            existing_github_ids = user.github_events.pluck(:github_id)

            commits = filter_push_commit github_user_public_events
            commits.each do |event|
                github_id = event[:id]
                num_commits = event[:payload][:commits].size
                repo_name = event[:repo][:name]
                branch = event[:payload][:ref].split('/').last 
                event_date = event[:created_at]

                if !existing_github_ids.include? github_id
                    github_event = GithubEvent.create! repo_name: repo_name, branch: branch, event_name: "PushEvent", github_id: github_id, user: user, date: event_date

                    TimelineItem.create! timelineable: github_event, user: user, event: TimelineItem::PUSH_GITHUB_COMMITS_TO_BRANCH, message: "Pushed #{num_commits} #{"commit".pluralize(num_commits)} to #{repo_name} #{branch}", date: event_date 
                end
            end

            repos = filter_create_repo github_user_public_events
            repos.each do |event|
                github_id = event[:id]
                repo_name = event[:repo][:name]
                event_date = event[:created_at]

                if !existing_github_ids.include? github_id
                    github_event = GithubEvent.create! repo_name: repo_name, event_name: "CreateEvent", github_id: github_id, user: user, date: event_date

                    TimelineItem.create! timelineable: github_event, user: user, event: TimelineItem::CREATE_NEW_GITHUB_REPOSITORY, message: "Created a new repository #{repo_name}", date: event_date
                end
            end

            open_pr = filter_open_pr github_user_public_events
            open_pr.each do |event|
                github_id = event[:id]
                repo_name = event[:repo][:name]
                event_date = event[:created_at]
                pr_number = event[:payload][:number]

                if !existing_github_ids.include? github_id
                    github_event = GithubEvent.create! repo_name: repo_name, event_name: "PullRequestEvent", github_id: github_id, user: user, date: event_date

                    TimelineItem.create! timelineable: github_event, user: user, event: TimelineItem::OPEN_NEW_GITHUB_PULL_REQUEST, message: "Opened a new Pull Request ##{pr_number} for #{repo_name}", date: event_date 
                end
            end
            
            merge_pr = filter_merge_pr github_user_public_events
            merge_pr.each do |event|
                github_id = event[:id]
                repo_name = event[:repo][:name]
                event_date = event[:created_at]
                pr_number = event[:payload][:number]

                if !existing_github_ids.include? github_id
                    github_event = GithubEvent.create! repo_name: repo_name, event_name: "PullRequestEvent", github_id: github_id, user: user, date: event_date

                    TimelineItem.create! timelineable: github_event, user: user, event: TimelineItem::MERGE_GITHUB_PULL_REQUEST, message: "Merged ##{pr_number} into #{repo_name}", date: event_date
                end
            end
        end

        pagy, records = pagy(user.timeline_items.order(date: :desc), limit: 7)
        
        render json: { data:  records, links: pagy_jsonapi_links(pagy) }
    end

    private

    def filter_push_commit(events)
        events.filter {|event| event[:type] == "PushEvent" }
    end

    def filter_create_repo(events)
        events.filter do |event| 
            event[:type] == "CreateEvent" &&
            event[:payload][:ref_type] == "repository"
        end
    end

    def filter_open_pr(events)
        events.filter do |event|
            event[:type] == "PullRequestEvent" &&
            event[:payload][:action] == "opened"
        end
    end

    def filter_merge_pr(events)
        events.filter do |event|
            event[:type] == "PullRequestEvent" &&
            event[:payload][:action] == "closed" &&
            ["refs/heads/master", "refs/heads/main"].include?(event[:payload][:ref])
        end
    end

    def user_params
        params.require(:user).permit(:email, :name, :password)
    end
end
