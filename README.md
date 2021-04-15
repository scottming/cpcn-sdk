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

Convert the public_key_file to a pem file

```bash
$ openssl x509 -pubkey -noout -in paytest.cer > pubkey.pem
```

then in your config file, config like this:


```elixir
config :cpcn_sdk,
  algorithm: :sha1, # :sha1 or :sha256
  pass: <pass>,
  private_key_path: <path to private_key_path>,
  public_key_path: <path to public_key_path>
```


## Examples


Please check the test files:

* `test/cpcn_sdk/tx_type_test.exs`
* `examples/dummy/test/dummy_test.exs`
