module GithubAPI
    EVENTS = [
        CREATE_REPO = "CreateEvent",
        OPEN_PULL_REQUEST = "PullRequestEvent",
        MERGE_PULL_REQUEST = "PullRequestEvent",
        PUSH_COMMIT = "PushEvent"
    ]
    
    def self.fetch_user_public_events
        Octokit.user_events("torvalds", type: "CreateEvent").size
    end
end