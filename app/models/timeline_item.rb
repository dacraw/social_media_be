class TimelineItem < ApplicationRecord
    belongs_to :timelineable, polymorphic: true
    belongs_to :user

    validates_presence_of :event

    EVENTS = [
        CREATE_POST = "create_post",
        COMMENT_ON_POST = "comment_on_post",
        SURPASS_4_STARS = "surpass_4_stars",
        CREATE_NEW_GITHUB_REPOSITORY = "create_new_github_repository",
        OPEN_NEW_GITHUB_PULL_REQUEST = "open_new_github_pull_request",
        MERGE_GITHUB_PULL_REQUEST = "merge_github_pull_request",
        PUSH_GITHUB_COMMITS_TO_BRANCH = "push_github_commits_to_branch"
    ]
end
