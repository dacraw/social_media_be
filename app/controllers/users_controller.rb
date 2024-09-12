class UsersController < ApplicationController
    def timeline
        user = User.find(params[:id])

        if user.github_username
            github_user_public_events = Octokit.user_events user.github_username
            github_user_public_events = Octokit.user_events "daimajia"
            
            commits = filter_push_commit github_user_public_events
            commit_github_ids = user.
            debugger
            commits.each do |event|
                github_id = event.id
                num_commits = event.payload.commits.size
                repo_name = event.repo.name
                branch = event.payload.ref.split('/').last 

                github_event = GithubEvent.create! repo_name: repo_name, branch: branch, event_name: GithubAPI::PUSH_COMMIT, github_id: github_id
                TimelineItem.create! timelineable: github_event, user: user, event: TimelineItem::PUSH_GITHUB_COMMITS_TO_BRANCH, message: "Pushed #{"commit".pluralize(num_commits)} to #{repo_name} #{branch}" 
            end

            repos = filter_create_repo github_user_public_events
            open_pr = filter_open_pr github_user_public_events
            merge_pr = filter_merge_pr github_user_public_events
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
