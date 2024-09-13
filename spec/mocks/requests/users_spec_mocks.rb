module UsersSpecMocks
    def self.mock_github_user_events
    [
        {:id=>"41888297049",
        :type=>"PushEvent",
        :actor=>
        {:id=>1024025,
        :login=>"torvalds",
        :display_login=>"torvalds",
        :gravatar_id=>"",
        :url=>"https://api.github.com/users/torvalds",
        :avatar_url=>"https://avatars.githubusercontent.com/u/1024025?"},
        :repo=>
        {:id=>2325298,
        :name=>"torvalds/linux",
        :url=>"https://api.github.com/repos/torvalds/linux"},
        :payload=>
        {:repository_id=>2325298,
        :push_id=>20215458693,
        :size=>2,
        :distinct_size=>2,
        :ref=>"refs/heads/master",
        :head=>"196145c606d0f816fd3926483cb1ff87e09c2c0b",
        :before=>"b8e7cd09ae543c1d384677b3d43e009a0e8647ca",
        :commits=>
            [{:sha=>"a4d89b11aca3ffa73e234f06685261ce85e5fb41",
            :author=>
            {:email=>"quic_skakitap@quicinc.com", :name=>"Satya Priya Kakitapalli"},
            :message=>
            "clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()\n" +
            "\n" +
            "In zonda_pll_adjust_l_val() replace the divide operator with comparison\n" +
            "operator to fix below build error and smatch warning.\n" +
            "\n" +
            "drivers/clk/qcom/clk-alpha-pll.o: In function `clk_zonda_pll_set_rate':\n" +
            "clk-alpha-pll.c:(.text+0x45dc): undefined reference to `__aeabi_uldivmod'\n" +
            "\n" +
            "smatch warnings:\n" +
            "drivers/clk/qcom/clk-alpha-pll.c:2129 zonda_pll_adjust_l_val() warn: replace\n" +
            "divide condition '(remainder * 2) / prate' with '(remainder * 2) >= prate'\n" +
            "\n" +
            "Fixes: f4973130d255 (\"clk: qcom: clk-alpha-pll: Update set_rate for Zonda PLL\")\n" +
            "Reported-by: Jon Hunter <jonathanh@nvidia.com>\n" +
            "Reported-by: kernel test robot <lkp@intel.com>\n" +
            "Reported-by: Dan Carpenter <dan.carpenter@linaro.org>\n" +
            "Closes: https://lore.kernel.org/r/202408110724.8pqbpDiD-lkp@intel.com/\n" +
            "Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>\n" +
            "Link: https://lore.kernel.org/r/20240906113905.641336-1-quic_skakitap@quicinc.com\n" +
            "Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>\n" +
            "Tested-by: Jon Hunter <jonathanh@nvidia.com>\n" +
            "Signed-off-by: Stephen Boyd <sboyd@kernel.org>",
            :distinct=>true,
            :url=>
            "https://api.github.com/repos/torvalds/linux/commits/a4d89b11aca3ffa73e234f06685261ce85e5fb41"},
            {:sha=>"196145c606d0f816fd3926483cb1ff87e09c2c0b",
            :author=>
            {:email=>"torvalds@linux-foundation.org", :name=>"Linus Torvalds"},
            :message=>
            "Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux\n" +
            "\n" +
            "Pull clk fix from Stephen Boyd:\n" +
            " \"One build fix for 32-bit arches using the Qualcomm PLL driver. It's\n" +
            "  cheaper to use a comparison here instead of a division so we just do\n" +
            "  that to fix the build\"\n" +
            "\n" +
            "* tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux:\n" +
            "  clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()",
            :distinct=>true,
            :url=>
            "https://api.github.com/repos/torvalds/linux/commits/196145c606d0f816fd3926483cb1ff87e09c2c0b"}]},
        :public=>true,
        :created_at=>"2024-09-15 23:34:22 UTC"},
        {:id=>"41888297050",
        :type=>"CreateEvent",
        :actor=>
        {:id=>1024025,
        :login=>"torvalds",
        :display_login=>"torvalds",
        :gravatar_id=>"",
        :url=>"https://api.github.com/users/torvalds",
        :avatar_url=>"https://avatars.githubusercontent.com/u/1024025?"},
        :repo=>
        {:id=>2325298,
        :name=>"torvalds/linux",
        :url=>"https://api.github.com/repos/torvalds/linux"},
        :payload=>
        {:repository_id=>2325298,
        :push_id=>20215458693,
        :size=>2,
        :distinct_size=>2,
        :ref_type => "repository",
        :ref=>"refs/heads/master",
        :head=>"196145c606d0f816fd3926483cb1ff87e09c2c0b",
        :before=>"b8e7cd09ae543c1d384677b3d43e009a0e8647ca",
        :commits=>
            [{:sha=>"a4d89b11aca3ffa73e234f06685261ce85e5fb41",
            :author=>
            {:email=>"quic_skakitap@quicinc.com", :name=>"Satya Priya Kakitapalli"},
            :message=>
            "clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()\n" +
            "\n" +
            "In zonda_pll_adjust_l_val() replace the divide operator with comparison\n" +
            "operator to fix below build error and smatch warning.\n" +
            "\n" +
            "drivers/clk/qcom/clk-alpha-pll.o: In function `clk_zonda_pll_set_rate':\n" +
            "clk-alpha-pll.c:(.text+0x45dc): undefined reference to `__aeabi_uldivmod'\n" +
            "\n" +
            "smatch warnings:\n" +
            "drivers/clk/qcom/clk-alpha-pll.c:2129 zonda_pll_adjust_l_val() warn: replace\n" +
            "divide condition '(remainder * 2) / prate' with '(remainder * 2) >= prate'\n" +
            "\n" +
            "Fixes: f4973130d255 (\"clk: qcom: clk-alpha-pll: Update set_rate for Zonda PLL\")\n" +
            "Reported-by: Jon Hunter <jonathanh@nvidia.com>\n" +
            "Reported-by: kernel test robot <lkp@intel.com>\n" +
            "Reported-by: Dan Carpenter <dan.carpenter@linaro.org>\n" +
            "Closes: https://lore.kernel.org/r/202408110724.8pqbpDiD-lkp@intel.com/\n" +
            "Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>\n" +
            "Link: https://lore.kernel.org/r/20240906113905.641336-1-quic_skakitap@quicinc.com\n" +
            "Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>\n" +
            "Tested-by: Jon Hunter <jonathanh@nvidia.com>\n" +
            "Signed-off-by: Stephen Boyd <sboyd@kernel.org>",
            :distinct=>true,
            :url=>
            "https://api.github.com/repos/torvalds/linux/commits/a4d89b11aca3ffa73e234f06685261ce85e5fb41"},
            {:sha=>"196145c606d0f816fd3926483cb1ff87e09c2c0b",
            :author=>
            {:email=>"torvalds@linux-foundation.org", :name=>"Linus Torvalds"},
            :message=>
            "Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux\n" +
            "\n" +
            "Pull clk fix from Stephen Boyd:\n" +
            " \"One build fix for 32-bit arches using the Qualcomm PLL driver. It's\n" +
            "  cheaper to use a comparison here instead of a division so we just do\n" +
            "  that to fix the build\"\n" +
            "\n" +
            "* tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux:\n" +
            "  clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()",
            :distinct=>true,
            :url=>
            "https://api.github.com/repos/torvalds/linux/commits/196145c606d0f816fd3926483cb1ff87e09c2c0b"}]},
        :public=>true,
        :created_at=>"2024-09-12 23:34:22 UTC"},
        {:id=>"41888297051",
        :type=>"PullRequestEvent",
        :actor=>
        {:id=>1024025,
        :login=>"torvalds",
        :display_login=>"torvalds",
        :gravatar_id=>"",
        :url=>"https://api.github.com/users/torvalds",
        :avatar_url=>"https://avatars.githubusercontent.com/u/1024025?"},
        :repo=>
        {:id=>2325298,
        :name=>"torvalds/linux",
        :url=>"https://api.github.com/repos/torvalds/linux"},
        :payload=>
        {:repository_id=>2325298,
        :push_id=>20215458693,
        :size=>2,
        :distinct_size=>2,
        :action => "opened",
        :ref_type => "repository",
        :ref=>"refs/heads/master",
        :number=>5,
        :head=>"196145c606d0f816fd3926483cb1ff87e09c2c0b",
        :before=>"b8e7cd09ae543c1d384677b3d43e009a0e8647ca",
        :commits=>
            [{:sha=>"a4d89b11aca3ffa73e234f06685261ce85e5fb41",
            :author=>
            {:email=>"quic_skakitap@quicinc.com", :name=>"Satya Priya Kakitapalli"},
            :message=>
            "clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()\n" +
            "\n" +
            "In zonda_pll_adjust_l_val() replace the divide operator with comparison\n" +
            "operator to fix below build error and smatch warning.\n" +
            "\n" +
            "drivers/clk/qcom/clk-alpha-pll.o: In function `clk_zonda_pll_set_rate':\n" +
            "clk-alpha-pll.c:(.text+0x45dc): undefined reference to `__aeabi_uldivmod'\n" +
            "\n" +
            "smatch warnings:\n" +
            "drivers/clk/qcom/clk-alpha-pll.c:2129 zonda_pll_adjust_l_val() warn: replace\n" +
            "divide condition '(remainder * 2) / prate' with '(remainder * 2) >= prate'\n" +
            "\n" +
            "Fixes: f4973130d255 (\"clk: qcom: clk-alpha-pll: Update set_rate for Zonda PLL\")\n" +
            "Reported-by: Jon Hunter <jonathanh@nvidia.com>\n" +
            "Reported-by: kernel test robot <lkp@intel.com>\n" +
            "Reported-by: Dan Carpenter <dan.carpenter@linaro.org>\n" +
            "Closes: https://lore.kernel.org/r/202408110724.8pqbpDiD-lkp@intel.com/\n" +
            "Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>\n" +
            "Link: https://lore.kernel.org/r/20240906113905.641336-1-quic_skakitap@quicinc.com\n" +
            "Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>\n" +
            "Tested-by: Jon Hunter <jonathanh@nvidia.com>\n" +
            "Signed-off-by: Stephen Boyd <sboyd@kernel.org>",
            :distinct=>true,
            :url=>
            "https://api.github.com/repos/torvalds/linux/commits/a4d89b11aca3ffa73e234f06685261ce85e5fb41"},
            {:sha=>"196145c606d0f816fd3926483cb1ff87e09c2c0b",
            :author=>
            {:email=>"torvalds@linux-foundation.org", :name=>"Linus Torvalds"},
            :message=>
            "Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux\n" +
            "\n" +
            "Pull clk fix from Stephen Boyd:\n" +
            " \"One build fix for 32-bit arches using the Qualcomm PLL driver. It's\n" +
            "  cheaper to use a comparison here instead of a division so we just do\n" +
            "  that to fix the build\"\n" +
            "\n" +
            "* tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux:\n" +
            "  clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()",
            :distinct=>true,
            :url=>
            "https://api.github.com/repos/torvalds/linux/commits/196145c606d0f816fd3926483cb1ff87e09c2c0b"}]},
        :public=>true,
        :created_at=>"2024-09-18 23:34:22 UTC"},
        {:id=>"41888297052",
        :type=>"PullRequestEvent",
        :actor=>
        {:id=>1024025,
        :login=>"torvalds",
        :display_login=>"torvalds",
        :gravatar_id=>"",
        :url=>"https://api.github.com/users/torvalds",
        :avatar_url=>"https://avatars.githubusercontent.com/u/1024025?"},
        :repo=>
        {:id=>2325298,
        :name=>"torvalds/linux",
        :url=>"https://api.github.com/repos/torvalds/linux"},
        :payload=>
        {:repository_id=>2325298,
        :number=>5,
        :push_id=>20215458693,
        :size=>2,
        :distinct_size=>2,
        :action => "closed",
        :ref_type => "repository",
        :ref=>"refs/heads/master",
        :head=>"196145c606d0f816fd3926483cb1ff87e09c2c0b",
        :before=>"b8e7cd09ae543c1d384677b3d43e009a0e8647ca",
        :commits=>
            [{:sha=>"a4d89b11aca3ffa73e234f06685261ce85e5fb41",
            :author=>
            {:email=>"quic_skakitap@quicinc.com", :name=>"Satya Priya Kakitapalli"},
            :message=>
            "clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()\n" +
            "\n" +
            "In zonda_pll_adjust_l_val() replace the divide operator with comparison\n" +
            "operator to fix below build error and smatch warning.\n" +
            "\n" +
            "drivers/clk/qcom/clk-alpha-pll.o: In function `clk_zonda_pll_set_rate':\n" +
            "clk-alpha-pll.c:(.text+0x45dc): undefined reference to `__aeabi_uldivmod'\n" +
            "\n" +
            "smatch warnings:\n" +
            "drivers/clk/qcom/clk-alpha-pll.c:2129 zonda_pll_adjust_l_val() warn: replace\n" +
            "divide condition '(remainder * 2) / prate' with '(remainder * 2) >= prate'\n" +
            "\n" +
            "Fixes: f4973130d255 (\"clk: qcom: clk-alpha-pll: Update set_rate for Zonda PLL\")\n" +
            "Reported-by: Jon Hunter <jonathanh@nvidia.com>\n" +
            "Reported-by: kernel test robot <lkp@intel.com>\n" +
            "Reported-by: Dan Carpenter <dan.carpenter@linaro.org>\n" +
            "Closes: https://lore.kernel.org/r/202408110724.8pqbpDiD-lkp@intel.com/\n" +
            "Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>\n" +
            "Link: https://lore.kernel.org/r/20240906113905.641336-1-quic_skakitap@quicinc.com\n" +
            "Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>\n" +
            "Tested-by: Jon Hunter <jonathanh@nvidia.com>\n" +
            "Signed-off-by: Stephen Boyd <sboyd@kernel.org>",
            :distinct=>true,
            :url=>
            "https://api.github.com/repos/torvalds/linux/commits/a4d89b11aca3ffa73e234f06685261ce85e5fb41"},
            {:sha=>"196145c606d0f816fd3926483cb1ff87e09c2c0b",
            :author=>
            {:email=>"torvalds@linux-foundation.org", :name=>"Linus Torvalds"},
            :message=>
            "Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux\n" +
            "\n" +
            "Pull clk fix from Stephen Boyd:\n" +
            " \"One build fix for 32-bit arches using the Qualcomm PLL driver. It's\n" +
            "  cheaper to use a comparison here instead of a division so we just do\n" +
            "  that to fix the build\"\n" +
            "\n" +
            "* tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux:\n" +
            "  clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()",
            :distinct=>true,
            :url=>
            "https://api.github.com/repos/torvalds/linux/commits/196145c606d0f816fd3926483cb1ff87e09c2c0b"}]},
        :public=>true,
        :created_at=>"2024-09-20 23:34:22 UTC"},
    ]
    end
end