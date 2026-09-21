# InfiniteLoop-CN

`InfiniteLoop-CN` is a CN-client-only fork of [InfiniteLoop](https://github.com/reiserFSs/InfiniteLoop), itself based on [AscNet](https://github.com/rafi1212122/AscNet). It is research and development infrastructure for a local Punishing: Gray Raven server, not an official service.

CN KRSDK differs from EN/TW paths: it uses QR-code, Kuro-account, and phone-verification login flows. CN KRSDKEx first exchanges an authorization code for a user token. The SDK server and root `proxy.py` therefore provide CN-specific routing and account-login compatibility.

## Requirements

- .NET SDK 8
- MongoDB listening on `127.0.0.1:27017`
- Python 3.10+ and mitmproxy (`mitmdump`) for client traffic routing
- A local CN PC client

## Run On Windows

1. Start MongoDB.
2. Run the server from the repository root:

   ```powershell
   dotnet run --project "AscNet/AscNet.csproj" -- --urls http://127.0.0.1:8080
   ```

3. Install mitmproxy, for example with `py -m pip install mitmproxy`. On its first launch, mitmproxy creates a local CA certificate. Install and trust that certificate for the Windows user before launching the game.
4. Put `run_windows.bat` on your game path (i.e., the path of `PGR.exe`), and `proxy.py` on `<game_path>/Proxy` (which the folder has `mitmdump.exe`).
5. Run `run_windows.bat` and enjoy.

The proxy does not store request or response bodies. Set `ASCNET_PROXY_LOG` when concise, credential-redacted flow diagnostics are needed.

## Publish

Publish a self-contained Windows x64 single-file host:

```powershell
dotnet publish "AscNet/AscNet.csproj" -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true
```

Publish a self-contained Linux x64 single-file host:

```bash
dotnet publish "AscNet/AscNet.csproj" -c Release -r linux-x64 --self-contained true -p:PublishSingleFile=true
```

Both commands write to `AscNet/bin/Release/net8.0/<runtime>/publish/`. Deploy the complete publish directory: the host loads `Resources/Configs` and `Resources/table` at runtime.

## Sync

I will synchronize with [reiserFSs/InfiniteLoop](https://github.com/reiserFSs/InfiniteLoop) when available.
