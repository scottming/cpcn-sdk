# CPCNSdk

中金支付的 SDK，基于 PHP 版

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cpcn_sdk` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cpcn_sdk, "~> 0.1.0", github: "scottming/cpcn_sdk"}
  ]
end
```

## Usage

In your config file

```elixir
config :cpcn_sdk,
  algorithm: :sha1,
  pass: <pass>,
  private_key_path: <path to private_key_path>,
  public_key_path: <path to public_key_path>
```


