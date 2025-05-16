{ config, pkgs, lib, ... }:

{
  home = {
    username = "shafael170";
    homeDirectory = "/home/shafael170";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      free = "free -m";
      nix-switch = "sudo nixos-rebuild switch";
      nix-upgrade = "sudo nixos-rebuild switch --upgrade";
      nix-clean = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system && sudo nix-collect-garbage";
    };
    functions = {
      pythonEnv = ''
        function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
        if set -q argv[2]
          set argv $argv[2..-1]
        end
      
        for el in $argv
          set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
        end
      
        nix-shell -p $ppkgs
        end
      '';
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName  = "Shafa'el Zmeyev";
    userEmail = "shafael170@gmail.com";
  };

  programs.nixcord = {
    enable = true;
    discord = {
      enable = true;
      branch = "stable";
      vencord = {
        enable = true;
        unstable = true;
      };
      openASAR.enable = true;
    };
    config = {
      enableReactDevtools = true;
      disableMinSize = true;
      plugins = {
        betterRoleContext = {
          enable = true;
          roleIconFileFormat = "png";
        };
        betterSessions = {
          enable = true;
          backgroundCheck = true;
          checkInterval = 15;
        };
        betterSettings = {
          enable = true;
          disableFade = true;
          organizeMenu = true;
          eagerLoad = true;
        };
        biggerStreamPreview.enable = true;
        blurNSFW = {
          enable = true;
          blurAmount = 25;
        };
        callTimer = {
          enable = true;
          format = "human";
        };
        clearURLs.enable = true;
        clientTheme = {
          enable = true;
          color = "292b31";
        };
        consoleJanitor = {
          enable = true;
          disableLoggers = false;
          disableSpotifyLogger = true;
          whitelistedLoggers = "GatewaySocket; Routing/Utils";
        };
        crashHandler = {
          enable = true;
          attemptToPreventCrashes = true;
          attemptToNavigateToHome = true;
        };
        emoteCloner.enable = true;
        experiments = {
          enable = true;
          toolbarDevMenu = false;
        };
        fakeNitro = {
          enable = true;
          enableEmojiBypass = true;
          emojiSize = 48;
          transformEmojis = true;
          enableStickerBypass = true;
          stickerSize = 160;
          transformStickers = true;
          transformCompoundSentence = false;
          enableStreamQualityBypass = true;
          useHyperLinks = true;
          hyperLinkText = "{{NAME}}";
          disableEmbedPermissionCheck = false;
        };
        fixCodeblockGap.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds = {
          enable = true;
          volume = 10.0;
        };
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendsSince.enable = true;
        fullSearchContext.enable = true;
        fullUserInChatbox.enable = true;
        imageZoom = {
          enable = true;
          saveZoomValues = true;
          invertScroll = true;
          nearestNeighbour = false;
          square = false;
          zoom = 2.0;
          size = 100.0;
          zoomSpeed = 0.5;
        };
        implicitRelationships = {
          enable = true;
          sortByAffinity = true;
        };
        keepCurrentChannel.enable = true;
        memberCount = {
          enable = true;
          toolTip = true;
          memberList = true;
        };
        mentionAvatars = {
          enable = true;
          showAtSymbol = true;
        };
        messageLinkEmbeds = {
          enable = true;
          automodEmbeds = "never";
          listMode = "blacklist";
          idList = "";
        };
        messageLogger = {
          enable = true;
          deleteStyle = "overlay";
          logDeletes = true;
          collapseDeleted = true;
          logEdits = true;
          inlineEdits = true;
          ignoreBots = false;
          ignoreSelf = false;
          ignoreUsers = "";
          ignoreChannels = "";
          ignoreGuilds = "";
        };
        mutualGroupDMs.enable = true;
        noBlockedMessages.enable = true;
        noDevtoolsWarning.enable = true;
        noOnboardingDelay.enable = true;
        normalizeMessageLinks.enable = true;
        noUnblockToJump.enable = true;
        nsfwGateBypass.enable = true;
        permissionFreeWill = {
          enable = true;
          lockout = true;
          onboarding = true;
        };
        permissionsViewer.enable = true;
        platformIndicators = {
          enable = true;
          lists = true;
          badges = true;
          messages = true;
          colorMobileIndicator = true;
        };
        relationshipNotifier = {
          enable = true;
          notices = true;
          offlineRemovals = true;
          friends = true;
          friendRequestCancels = true;
          servers = true;
          groups = true;
        };
        reverseImageSearch.enable = true;
        roleColorEverywhere = {
          enable = true;
          chatMentions = true;
          memberList = true;
          voiceUsers = true;
          reactorsList = true;
          colorChatMessages = false;
          messageSaturation = 30;
        };
        summaries = {
          enable = true;
          summaryExpiryThresholdDays = 10;
        };
        sendTimestamps = {
          enable = true;
          replaceMessageContents = true;
        };
        serverInfo.enable = true;
        serverListIndicators = {
          enable = true;
          mode = "both";
        };
        showConnections = {
          enable = true;
          iconSpacing = "cozy";
          iconSize = 32;
        };
        showHiddenChannels = {
          enable = true;
          hideUnreads = false;
          showMode = "muted";
        };
        showHiddenThings = {
          enable = true;
          showTimeouts = true;
          showInvitesPaused = true;
          showModView = true;
        };
        showMeYourName = {
          enable = true;
          mode = "nick-user";
        };
        showTimeoutDuration = {
          enable = true;
          displayStyle = "ssalggnikool";
        };
        silentTyping = {
          enable = true;
          showIcon = true;
          isEnabled = false;
        };
        spotifyControls = {
          enable = true;
          hoverControls = false;
          useSpotifyUris = false;
        };
        spotifyCrack = {
          enable = true;
          noSpotifyAutoPause = true;
          keepSpotifyActivityOnIdle = false;
        };
        superReactionTweaks = {
          enable = true;
          superReactByDefault = false;
          unlimitedSuperReactionPlaying = false;
          superReactionPlayingLimit = 0;
        };
        themeAttributes.enable = true;
        translate = {
          enable = true;
          showChatBarButton = true;
          autoTranslate = false;
        };
        typingIndicator = {
          enable = true;
          includeCurrentChannel = true;
          includeMutedChannels = true;
          includeBlockedUsers = true;
          indicatorMode = "animatedDots";
        };
        typingTweaks = {
          enable = true;
          showAvatars = true;
          showRoleColors = true;
          alternativeFormatting = true;
        };
        userVoiceShow = {
          enable = true;
          showInMemberList = true;
          showInMessages = true;
        };
        validReply.enable = true;
        validUser.enable = true;
        viewIcons = {
          enable = true;
          format = "png";
          imgSize = 4096;
        };
        voiceDownload.enable = true;
        voiceMessages = {
          enable = true;
          noiseSuppression = true;
          echoCancellation = true;
        };
        youtubeAdblock.enable = true;
      };
    };
    userPlugins = {
      discordColorways = "github:DaBluLite/DiscordColorways-VencordUserplugin/0e52af670756425cdd1edc3f022d2ab8835cbe29";
      loginWithQR = "github:nexpid/vc-loginWithQR/37213a3f7365471bb2dcb3eb934537c7676fc92d";
      messageLoggerEnhanced = "github:Syncxv/vc-message-logger-enhanced/2714caba22ddcad395bf32071c6c64c30bb74f47";
      themeLibrary = "github:Faf4a/ThemeLibrary/8ffc2ad39786bac29e9513f6745bda6f03bacb5e";
      sidebarChat = "github:Masterjoona/vc-sidebarchat/1ca8b3cafd5eb8b347d728fc774886a6ddd49dba";
      silentTypingEnhanced = "github:D3SOX/vc-silentTypingEnhanced/c2fdd7005d80e888b7f5df45999487a78fbdb8b4";
    };
    extraConfig = {
      plugins = {
        discordColorways.enable = true;
        loginWithQR.enable = true;
        messageLoggerEnhanced = {
          enable = true;
          saveMessages = true;
          saveImages = true;
          sortNewest = true;
          cacheMessagesFromServers = true;
          autoCheckForUpdates = true;
          ignoreBots = false;
          ignoreSelf = false;
          ignoreMutedGuilds = false;
          ignoreMutedCategories = false;
          ignoreMutedChannels = false;
          alwaysLogDirectMessages = true;
          alwaysLogCurrentChannel = true;
          permanentlyRemoveLogByDefault = true;
          hideMessageFromMessageLoggers = false;
          ShowLogsButton = true;
          messagesToDisplayAtOnceInLogs = 1000;
          hideMessageFromMessageLoggersDeletedMessage = "redacted eh";
          messageLimit = 20000;
          attachmentSizeLimitInMegabytes = 500;
          attachmentFileExtensions = "png,jpg,jpeg,gif,webp,mp4,webm,mp3,opus,ogg,wav,m4a,flac";
          cacheLimit = 100000;
          whitelistedIds = "";
          blacklistedIds = "";
          imageCacheDir = "/home/shafael170/.config/Vencord/MessageLoggerData/savedImages";
          logsDir = "/home/shafael170/.config/Vencord/MessageLoggerData";
        };
        themeLibrary = {
          enable = true;
          hideWarningCard = true;
        };
        sidebarChat = {
          enable = true;
          persistSidebar = true;
        };
        silentTypingEnhanced = {
          enable = true;
          specificChats = true;
          disabledFor = "";
        };
      };
    };
  };
}