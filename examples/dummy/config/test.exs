use Mix.Config

config :cpcn_sdk,
  algorithm: :sha1,
  pass: "example",
  private_key_path: System.get_env("private_key_path"),
  public_key_path: System.get_env("public_key_path")
