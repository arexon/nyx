{inputs, ...}: {
  flake-file.inputs.nix-minecraft = {
    url = "github:Infinidoge/nix-minecraft";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.minecraft = {pkgs, ...}: {
    imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];

    nixpkgs.overlays = [inputs.nix-minecraft.overlay];

    # tmux console: tmux -S /run/minecraft/main.sock attach
    users.users.arexon.extraGroups = ["minecraft"];

    services.minecraft-servers = {
      enable = true;
      eula = true;
      servers.main = {
        enable = true;
        package = pkgs.neoforgeServers.neoforge-1_21_1-21_1_249;
        jvmOpts = "-Xms8G -Xmx8G";
        serverProperties = {
          difficulty = "normal";
          allow-flight = true;
          max-players = 4;
          view-distance = 24;
          simulation-distance = 12;
          motd = "The Silly World :3";
        };
        symlinks.mods = with pkgs;
          linkFarmFromDrvs "mods" (builtins.attrValues {
            "balm" = fetchurl {
              url = "https://cdn.modrinth.com/data/MBAkmtvl/versions/KgypwTqX/balm-neoforge-1.21.1-21.0.65.jar";
              sha512 = "779b4f9e9738ae6f010e87f71b2ed5a114eb9b1b3d5b55cf42ad538094e5b064a1d3f4ff00064aac90da1c841a144464d47378d9bffc448a71d87132cb954101";
            };
            "biolith" = fetchurl {
              url = "https://cdn.modrinth.com/data/iGEl6Crx/versions/EAjbdreT/biolith-neoforge-3.0.14.jar";
              sha512 = "49d225425627eca3b52514752ad297d39c571853a72f4e539c6e233a1289126fbb50593b01af2a782369e1aca55654e225ae25d494c3885baf6ed9fe212887ad";
            };
            "companion" = fetchurl {
              url = "https://cdn.modrinth.com/data/4w0EzGRW/versions/PfXPQBGy/Companion-1.21.1-NeoForge-6.3.0.jar";
              sha512 = "bdc3b9d19c3650366404a6c4e0959b19ce9759a0861b5df05262eaf9af3ae6b0ed931dfe62b9cf61fe2b92f21bd9ea320822512af8cd27636edcc0010b2ddc7c";
            };
            "connector" = fetchurl {
              url = "https://cdn.modrinth.com/data/u58R1TMW/versions/IITF0PRC/connector-2.0.0-beta.17%2B1.21.1-full.jar";
              sha512 = "cb92b662047208792e61191d372d1e255766200406c35769007101f8c578c1018938610c3b90352afd93ec42d7963acf3607e35c50e669df50ac85d7c5529560";
            };
            "copycats" = fetchurl {
              url = "https://cdn.modrinth.com/data/UT2M39wf/versions/bPYeUWZx/copycats-3.0.9%2Bmc.1.21.1-neoforge.jar";
              sha512 = "432b5cde473976476b0729172710d32805576d0c3a5fd66d21f882d96cef0c4eef1b85e4e3a1a316e2adc473784b11e156b0265b0f62bcfd5b035a6ff7dfcc6e";
            };
            "copycats+-aeronautics-weight" = fetchurl {
              url = "https://cdn.modrinth.com/data/wjpmYU1u/versions/wsXjRa7l/aerocopycats-1.1.1.jar";
              sha512 = "4f48c03a25a6f4ec022398cece20e5aa8d51f00951a0f568980e6e5419c1af2f12c8bb652500721afef119ecc455e4c5b1bc4bb7bef38d88846759f0e4c39e8c";
            };
            "create" = fetchurl {
              url = "https://cdn.modrinth.com/data/LNytGWDc/versions/UjX6dr61/create-1.21.1-6.0.10.jar";
              sha512 = "11cc8fc049d2f67f6548c7abfada6b82a3adb5c7ca410a742de04bbca76e03862c518721b88d806f6e6d768a4d68531fdb903a85859b25d1484d550cc7bafd4b";
            };
            "create-aeronautics" = fetchurl {
              url = "https://cdn.modrinth.com/data/oWaK0Q19/versions/44pLdPGg/create-aeronautics-bundled-1.21.1-1.3.2.jar";
              sha512 = "dc7e8e1148fa442243889ba29412207137e1bb86206e6c92bc0a589f1374a466e93de22bdbf14f753984d86c29308fbbdc0f14a4b9618b14c0ac1666a36b46f5";
            };
            "create-alloyed" = fetchurl {
              url = "https://cdn.modrinth.com/data/KUInlTFo/versions/BTj8TkEP/alloyed-3.0.11%2B1.21.1-neoforge.jar";
              sha512 = "0cf5f71b782fa5456fe4f10de83ba58e4495b42ded1602e21ae0ff76578af300241643f175716f7c12c1950e959281b626cb48d6ad5054ae7907717179b0dff0";
            };
            "farmers-delight" = fetchurl {
              url = "https://cdn.modrinth.com/data/R2OftAxM/versions/XTVZDOol/FarmersDelight-1.21.1-1.3.4.jar";
              sha512 = "1f6f8796469f747cff36f477b4f589a3d69613882399f9ee7f86db36c7bca9aa4828731f43db15dc6c7f5a4c1bbe3d4092a232e8cef010b09cec0581848fda90";
            };
            "ferrite-core" = fetchurl {
              url = "https://cdn.modrinth.com/data/uXXizFIs/versions/x7kQWVju/ferritecore-7.0.3-neoforge.jar";
              sha512 = "19af89a2075bb10a63884fa853ebf84b02c79dc3242430ecdad056fd764fdcde367a7303276b329df01b0736e2ef264c5d80c7dc92c6aebd244f556a230bb417";
            };
            "forgified-fabric-api" = fetchurl {
              url = "https://cdn.modrinth.com/data/Aqlf1Shp/versions/V9WdDUTx/forgified-fabric-api-0.116.15%2B2.3.5%2B1.21.1.jar";
              sha512 = "2b44ecd839544e3668a02f8de86433d507417d068dcafeee7f698744fc2b12fd888a1bba509da57c8e2884d01dbaf344f49bbac0f22cdae599507356ed0cbe30";
            };
            "geckolib" = fetchurl {
              url = "https://cdn.modrinth.com/data/8BmcQJ2H/versions/Grwn5rUB/geckolib-neoforge-1.21.1-4.9.3.jar";
              sha512 = "8dfa5f8c57224a5e34e5098367ea9819ca6dc9c11357cd3062c16da3455c8bd1a483098af7383debc4b9ce8e4d7ab3fdc799b415644eb829da83eb72a7335dfd";
            };
            "interiors" = fetchurl {
              url = "https://cdn.modrinth.com/data/r4Knci2k/versions/gBrfZy6S/interiors-1.21.1-neoforge-0.6.1.jar";
              sha512 = "68b0d915e41fb0ce9d12a8c580d688a604770ded2b21e963058aa6d80cbc5661c481416d051a541395b5c79f461edcb658046e53cfcfb405179a450662ed01b5";
            };
            "inventory-essentials" = fetchurl {
              url = "https://cdn.modrinth.com/data/Boon8xwi/versions/kSYg2mEh/inventoryessentials-neoforge-1.21.1-21.1.18.jar";
              sha512 = "7c0e1bb82bb28ea310eb28e2bf01fb44b351d856e6c9f5caa44d50e6f8a6625e92818f68191714c767244cc2f48f4a4789f9ddf3295420bbbee42d9148d6e84d";
            };
            "jei" = fetchurl {
              url = "https://cdn.modrinth.com/data/u6dRKJwZ/versions/ZWGz5dZX/jei-1.21.1-neoforge-19.56.0.441.jar";
              sha512 = "cee8f743819fdeb99fde9a91cd72b9200c07a7fd7e581e3b2561843fd0ee59f0b7dc7e0b619c79cee80402c7557eb4ae3b218bd05ec3e6d9e79801f01b791fa3";
            };
            "kiwi" = fetchurl {
              url = "https://cdn.modrinth.com/data/ufdDoWPd/versions/tfwJWC8g/Kiwi-1.21.1-NeoForge-15.8.7.jar";
              sha512 = "d01c347febcb3d77bbfd2f44f38a80afbf4cf0b72a2aaa5d1875a38cbcd78be5a263fae4f63685256ea29c5f5f5d0f1c46892e2c78c4c1204863415dec9f4151";
            };
            "kotlin-for-forge" = fetchurl {
              url = "https://cdn.modrinth.com/data/ordsPcFz/versions/uhJhCT7X/kotlinforforge-5.12.0-all.jar";
              sha512 = "b8c3942f4d33179edf3f102f3d870b99dd436f8b8236dbbd31aa51b888162c692cfd88927295f24dc8b4375232f4c6c17360c5d6c4823f93cbcd7cf4bdc8bd14";
            };
            "lithium" = fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/DDUrRVCA/lithium-neoforge-0.15.4%2Bmc1.21.1.jar";
              sha512 = "2735da2088b88a8bdcd4ad02a2b6fffbfd3925557cefd4fa54b5477dfb9e582ea7f521300c060f57dff1325dd21bff276b7333363ad3371ed6893e3de9eca9cd";
            };
            "lithostitched" = fetchurl {
              url = "https://cdn.modrinth.com/data/XaDC71GB/versions/xDAotknu/lithostitched-1.8.0%2Bbeta6-neoforge-21.1.jar";
              sha512 = "d3654fdab95ca5b929778a21fb30c2124f6f66e3c6067af23595301800d797f584dd099ce046f8ae288a6084e92c46a161a8238d19ac793bd3bface2b3b2eef8";
            };
            "mezzconfig" = fetchurl {
              url = "https://cdn.modrinth.com/data/7tEfOcA7/versions/Bg8bfSgj/mezz_config-1.21.1-neoforge-0.5.11.jar";
              sha512 = "cb62caa9d2c2e76eaf3400abc459e27180ed429d2421467b3d4de292ed1dfdf84a3b697118b5399bc2696cca5e94c4e76b968041928bdc6dbfe6b3fb5ac4829f";
            };
            "modernfix" = fetchurl {
              url = "https://cdn.modrinth.com/data/nmDcB62a/versions/5HLHxQ2F/modernfix-neoforge-5.27.24%2Bmc1.21.1.jar";
              sha512 = "da13fa15b2c96a74a7d5f8ea94ea404c96237b97d52c9a77e7e34ac918d28c40760a68cf3897691b317d5119ab9b85035142c3624108b13dda3516c340b96131";
            };
            "no-mans-delight" = fetchurl {
              url = "https://cdn.modrinth.com/data/8ffHF0Dn/versions/SenUsdj1/nomansdelight-2.2.0.jar";
              sha512 = "319306f8a1782cb26c8c803eb26c993f33da31fb229383d0b2db2f459174bbd65b1e5f27130a44b03defc485992213431b6e319c52129570aab1375bde00d1d1";
            };
            "no-mans-land" = fetchurl {
              url = "https://cdn.modrinth.com/data/kjZCvAn6/versions/bcszfrVc/nomansland-1.5.12.jar";
              sha512 = "64a4791b9c05b466442eb3203d6f57241035359cf8deb2d79f6e3664484619ed38ce0d3725960d42cffff4e889eb0c00474a3b5f7354b1aa3fb81f7fa3fde9b5";
            };
            "patpat" = fetchurl {
              url = "https://cdn.modrinth.com/data/dw7LChq9/versions/VKC3j9lS/PatPat-1.3.1%2B1.21.1%2Bneoforge.jar";
              sha512 = "a401c5687f8cc20c5c8c2f07bc04fcfaf8df64fcb343bef1a811e367814542633e93765facc0af280a5d427c9c7ecacdb7492d202d8b1ad4d9dfa28ab239e72f";
            };
            "plasmo-voice" = fetchurl {
              url = "https://cdn.modrinth.com/data/1bZhdhsH/versions/97HOKGM0/plasmovoice-neoforge-1.21.1-2.1.17.jar";
              sha512 = "6847a3d4b8ab6fcb14d57777bf54cca8798c23d746b4f4cf80fe31fae4a86995e7e1c5a6ad7e7ecc2a94afe3a79094d3afffcc0df7cf061e7a96c3eff6ac2d32";
            };
            "platform" = fetchurl {
              url = "https://cdn.modrinth.com/data/i6fiqm5y/versions/v7P0nBi2/Platform-neoforge-1.21.1-1.3.3.jar";
              sha512 = "1ab1dcf3583237dd30c3443a1fac3ee8271add25aae84af2933fa9eb13def3840d7a8cca53523d1dd3c5a77eb23059099285d218509d02d001034fca42f5f64d";
            };
            "puzzles-lib" = fetchurl {
              url = "https://cdn.modrinth.com/data/QAGBst4M/versions/lh44g7RC/PuzzlesLib-v21.1.60-mc1.21.1-NeoForge.jar";
              sha512 = "630bea2bfeed34074d82bc75a4e3f94bb8235d5ae4b13d59c3ee8832bd493eb34584e81d183c5447bd1754e1845d8397eb910d16678243f64e7df8389ce147ac";
            };
            "ribbits" = fetchurl {
              url = "https://cdn.modrinth.com/data/8YcE8y4T/versions/XrUKaWrw/Ribbits-1.21.1-NeoForge-4.1.6.jar";
              sha512 = "5e78b0d63757d5904b96e0c4565d56832ca42b1cbba939b98101f848f618cfcda94d5aeadeacb0faff85bdd05fb071f2df551a42c3e7d0e3a2564adbec227931";
            };
            "room-for-two" = fetchurl {
              url = "https://cdn.modrinth.com/data/YZlvzIFq/versions/nVyx08tS/roomfortwo-neoforge-1.21.1-0.3.0.jar";
              sha512 = "81cb8fa7a099af75339f05c562fea677479329d8cc3c449a231d564c90931d7bf10727af118966512bf2c114995be19a9cb41d0db008f0535eadb7892ad6fb89";
            };
            "sable" = fetchurl {
              url = "https://cdn.modrinth.com/data/T9PomCSv/versions/U678xqle/sable-neoforge-1.21.1-2.0.5.jar";
              sha512 = "bf3d8c87bcc5efb99afffd50305fc978086ed48a63e106816e3a8a3901f8052f4480ea527dbd7d4003f7775ed4d020529098034f4e307aefac9cc42df2b4c19a";
            };
            "slice-and-dice" = fetchurl {
              url = "https://cdn.modrinth.com/data/GmjmRQ0A/versions/N67LJgrN/sliceanddice-4.3.3-neoforge.jar";
              sha512 = "3bdbd282ae5aa11ef6c186b752497541730b50fb400c4962230bcd7734cfe4e8daa2ee565387450dfe0eb6deaa0fa44bf81f99c788bac09b1a60d8f1991db37f";
            };
            "sophisticated-backpacks" = fetchurl {
              url = "https://cdn.modrinth.com/data/TyCTlI4b/versions/AhPnzNtJ/sophisticatedbackpacks-1.21.1-3.26.3.2158.jar";
              sha512 = "66fe369708023762bff15e981c21ba5f73a7d286ee04d128838e439c63db1e9a61028acb820675ad2e22f238d3586e7cd006a579254df81740a99dc51dcdf279";
            };
            "sophisticated-core" = fetchurl {
              url = "https://cdn.modrinth.com/data/nmoqTijg/versions/PXl6rB3q/sophisticatedcore-1.21.1-1.5.1.2341.jar";
              sha512 = "0cb1ea870d3e76591935b8e6b0239c3cce598c57ac8cedcbc4e91a7b611d45df984b6b7d82037e5cf490b2c0731709b1efcb9455d2699eda0a8c378a857999dd";
            };
            "tectonic" = fetchurl {
              url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/n4iyW7aB/tectonic-3.0.28-neoforge-21.1.jar";
              sha512 = "e07b9cb54f078b7bf74c925c5cebd6643f0b4c210b8f94474e68659b69468ece7d61432f70eafe7abaa1dfa798e4638aad297987c121dc127588c2623b7f7a81";
            };
            "tree-physics" = fetchurl {
              url = "https://cdn.modrinth.com/data/AlVH5pr8/versions/nRQrvQIW/treephysics-neoforge-1.21.1-2.4.jar";
              sha512 = "5afefda3cc910f02b099b32360bc742f12ef3816c14e264671c8077bf67159c5239f66b0aadf2c9e53b916390a9b8baf791aa76668ce416513257f50a9a43479";
            };
            "vanillabackport" = fetchurl {
              url = "https://cdn.modrinth.com/data/6xwxDTgf/versions/rUSWdBok/VanillaBackport-neoforge-1.21.1-1.1.7.10.jar";
              sha512 = "be0622afd2f7d216e4d83aed9190dec6f6f6a2919cffcebe8f334989b91f148638efa1b3e1d4bb8aa6c83ffa5f775951d6b3bc75c0d45b70b5b389b4f3476b4f";
            };
            "xaero-head-tracker" = fetchurl {
              url = "https://cdn.modrinth.com/data/ckFfIvjk/versions/hl7XgzVg/XaeroHeadTracker-1.0.0-neoforge-1.21.1.jar";
              sha512 = "629bd82b3a487c55f2d938dc52cf9639f6f415bc8c614ebe63e124e682cc49fd04c1d743011e175fdc9e779794a25e8021301ee74969e193193a28cc23ef5c35";
            };
            "xaeros-world-map" = fetchurl {
              url = "https://cdn.modrinth.com/data/NcUtCpym/versions/9Ckiihkz/xaeroworldmap-neoforge-1.21.1-1.46.0.jar";
              sha512 = "fb14d11d66e0a6441981b18454c86534d8f534cd159ca19fa612950521788d858f37f18fe2093bb9b43ca0a88ae9af578eced5d140ff645a7681d7e452e8a268";
            };
            "yacl" = fetchurl {
              url = "https://cdn.modrinth.com/data/1eAoo2KR/versions/7TVdVtxF/yet_another_config_lib_v3-3.8.2%2B1.21.1-neoforge.jar";
              sha512 = "583de19b927ce8050c2b7d5e60b75accc69e325e5aac85c27994c82a9dec2e4e078343fa1d4c3a10d4bd7e0e524e0b3b246a18cf03db01e363a1e6f865adcf48";
            };
            "yungs-api" = fetchurl {
              url = "https://cdn.modrinth.com/data/Ua7DFN59/versions/2prKITKh/YungsApi-1.21.1-NeoForge-5.1.9.jar";
              sha512 = "7e3cf0b429e8a1c51dca094c2d8eabf12245bb42cbcd8b6e3e54959f931bef93201b81a08d200b417059aaa438e8eb445c3978a09568597bfb588199b7775967";
            };
          });
      };
    };
  };
}
