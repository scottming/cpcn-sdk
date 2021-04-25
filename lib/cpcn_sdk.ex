defmodule CPCNSdk do
  @moduledoc """
  Documentation for `CPCNSdk`.
  """

  def sign(xml_message) do
    private_key_path = config()[:private_key_path] || raise "Please config private_key_path"
    pass = config()[:pass] || raise "Please config pass"
    private_key = private_key_path |> decode_private_key_from(pass)

    sign(xml_message, private_key, algorithm())
  end

  def sign(xml_message, private_key, algorithm) do
    # save private_key and xml_message to file
    key_path = "keyfile"
    xml_message_path = "message.txt"
    :ok = File.write(key_path, private_key, [:write])
    :ok = File.write(xml_message_path, xml_message, [:write])

    {b, _} =
      case algorithm do
        :sha256 ->
          System.cmd("openssl", ["dgst", "-sha256", "-sign", key_path, xml_message_path])

        _ ->
          System.cmd("openssl", ["dgst", "-sha1", "-sign", key_path, xml_message_path])
      end

    File.rm(key_path)

    b |> Base.encode16()
  end

  def verify?(xml_message, signature) do
    public_key_path = config()[:public_key_path]
    decoded_signature = Base.decode16!(signature)
    verify?(xml_message, decoded_signature, public_key_path, algorithm())
  end

  def verify?(xml_message, signature, public_key_path, algorithm) do
    signature_path = "signature"
    xml_message_path = "message.txt"
    :ok = File.write(signature_path, signature, [:write])
    :ok = File.write(xml_message_path, xml_message, [:write])

    {result, _} =
      case algorithm do
        :sha256 ->
          System.cmd("openssl", [
            "dgst",
            "-sha256",
            "-verify",
            public_key_path,
            "-signature",
            signature_path,
            xml_message_path
          ])

        _ ->
          System.cmd("openssl", [
            "dgst",
            "-sha1",
            "-verify",
            public_key_path,
            "-signature",
            signature_path,
            xml_message_path
          ])
      end

    String.trim(result) == "Verified OK"
  end

  defp algorithm() do
    case config()[:algorithm] do
      :sha256 -> :sha256
      :sha1 -> :sha1
      _ -> raise "algorithm error, please set `:sha1` or `:sha256`"
    end
  end

  @doc """
  Return a private key string
  """
  def decode_private_key_from(path, pass) do
    {d, _} = System.cmd("openssl", ["pkcs12", "-in", path, "-nocerts", "-nodes", "-passin", "pass:#{pass}"])

    delimiter = "-----BEGIN PRIVATE KEY-----"
    [_, private_key] = d |> String.split(delimiter, parts: 2)
    delimiter <> private_key
  end

  def config() do
    Application.get_all_env(:cpcn_sdk)
  end
end
