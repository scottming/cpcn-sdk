defmodule CPCNSdk do
  @moduledoc """
  Documentation for `CPCNSdk`.
  """

  @doc """
  Return a private key string
  """
  def decode_private_key_from(path, opts \\ []) do
    pass = Keyword.get(opts, :pass) || "511"
    {d, _} = System.cmd("openssl", ["pkcs12", "-in", path, "-nocerts", "-nodes", "-passin", "pass:#{pass}"])

    delimiter = "-----BEGIN PRIVATE KEY-----"
    [_, private_key] = d |> String.split(delimiter, parts: 2)
    delimiter <> private_key
  end

  def sign(message, private_key, opts \\ []) do
    # save private_key and message to file
    key_name = "keyfile"
    message_name = "message.txt"
    {:ok, key_file} = File.open(key_name, [:write])
    {:ok, message_file} = File.open(message_name, [:write])

    IO.binwrite(key_file, private_key)
    IO.binwrite(message_file, message)
    File.close(key_file)
    File.close(message_file)

    algorithm = Keyword.get(opts, :algorithm) || :sha1

    {b, _} =
      case algorithm do
        :sha1 ->
          System.cmd("openssl", ["dgst", "-sha1", "-sign", key_name, message_name])

        :sha256 ->
          System.cmd("openssl", ["dgst", "-sha256", "-sign", key_name, message_name])

        _ ->
          raise "algorithm error."
      end

    File.rm(key_name)

    b |> Base.encode16(case: :lower)
  end
end

