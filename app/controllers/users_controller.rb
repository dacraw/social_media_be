class UsersController < ApplicationController
    def timeline
        user = User.find(params[:id])

        if user.github_username
            github_user_public_events = Octokit.user_events user.github_username
            
            existing_github_ids = user.github_events.pluck(:github_id)

            commits = filter_push_commit github_user_public_events
            commits.each do |event|
                github_id = event.id
                num_commits = event.payload.commits.size
                repo_name = event.repo.name
                branch = event.payload.ref.split('/').last 
                event_date = event.created_at

                if !existing_github_ids.include? github_id
                    github_event = GithubEvent.create! repo_name: repo_name, branch: branch, event_name: GithubAPI::PUSH_COMMIT, github_id: github_id, user: user, date: event_date

                    TimelineItem.create! timelineable: github_event, user: user, event: TimelineItem::PUSH_GITHUB_COMMITS_TO_BRANCH, message: "Pushed #{num_commits} #{"commit".pluralize(num_commits)} to #{repo_name} #{branch}" 
                end
            end

            repos = filter_create_repo github_user_public_events
            repos.each do |event|
                github_id = event.id
                repo_name = event.repo.name
                event_date = event.created_at

                if !existing_github_ids.include? github_id
                    github_event = GithubEvent.create! repo_name: repo_name, event_name: GithubAPI::CREATE_REPO, github_id: github_id, user: user, date: event_date

                    TimelineItem.create! timelineable: github_event, user: user, event: TimelineItem::CREATE_NEW_GITHUB_REPOSITORY, message: "Created a new repository #{repo_name}" 
                end
            end

            open_pr = filter_open_pr github_user_public_events
            open_pr.each do |event|
                github_id = event.id
                repo_name = event.repo.name
                event_date = event.created_at
                pr_number = event.payload.number

                if !existing_github_ids.include? github_id
                    github_event = GithubEvent.create! repo_name: repo_name, event_name: GithubAPI::CREATE_REPO, github_id: github_id, user: user, date: event_date

                    TimelineItem.create! timelineable: github_event, user: user, event: TimelineItem::CREATE_NEW_GITHUB_REPOSITORY, message: "Opened a new Pull Request #{pr_number} for #{repo_name}" 
                end
            end
            
            merge_pr = filter_merge_pr github_user_public_events
            merge_pr.each do |event|
                github_id = event.id
                repo_name = event.repo.name
                event_date = event.created_at
                pr_number = event.payload.number

                if !existing_github_ids.include? github_id
                    github_event = GithubEvent.create! repo_name: repo_name, event_name: GithubAPI::CREATE_REPO, github_id: github_id, user: user, date: event_date

                    TimelineItem.create! timelineable: github_event, user: user, event: TimelineItem::CREATE_NEW_GITHUB_REPOSITORY, message: "Merged #{pr_number} into #{repo_name}" 
                end
            end
        end

        
        render json: { timeline_items: user.timeline_items.order(created_at: :desc) }
    end

    private

    def filter_push_commit(events)
        events.filter {|event| event.type == GithubAPI::PUSH_COMMIT }
    end

    def filter_create_repo(events)
        events.filter do |event| 
            event.type == GithubAPI::CREATE_REPO &&
            event.payload.ref_type == "repository"
        end
    end

    def filter_open_pr(events)
        events.filter do |event|
            event.type == GithubAPI::OPEN_PULL_REQUEST &&
            event.payload.action == "opened"
        end
    end

    def filter_merge_pr(events)
        events.filter do |event|
            event.type == GithubAPI::MERGE_PULL_REQUEST &&
            event.payload.action == "closed" &&
            ["refs/heads/master", "refs/heads/main"].include?(event.payload.ref)
        end
    end
end
