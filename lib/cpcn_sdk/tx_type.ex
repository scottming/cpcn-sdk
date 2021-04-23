defmodule CPCNSdk.TxType do
  import XmlBuilder

  defmodule KeysError do
    defexception [:keys, :message]

    def message(%{keys: keys}) do
      "keys: #{inspect(keys)} not support"
    end
  end

  def tx1112_str(opts \\ []) do
    tx1112(opts) |> document() |> generate()
  end

  def tx1120_str(opts) do
    tx1120(opts) |> document() |> generate()
  end

  defp tx1120(opts) do
    head = element(:Head, nil, [element(:TxCode, nil, 1120)])

    body =
      element(:Body, nil, [
        element(:InstitutionID, nil, opts[:InstitutionID]),
        element(:PaymentNo, nil, opts[:PaymentNo]),
        empty_element_or(:SourceTxTime, opts)
      ])

    element(:Request, %{version: 2.0}, [head, body])
  end

  @tx1112_keys ~w(InstitutionID PaymentNo Amount PayerID PayerName SplitType SettlementFlag Usage Remark Note NotificationURL)a
  def tx1112(opts) when is_list(opts) and opts != [] do
    supported = Map.new(@tx1112_keys, fn x -> {x, true} end)
    keys = Keyword.keys(opts)

    case Enum.filter(keys, fn x -> not Map.has_key?(supported, x) end) do
      [] -> internal_tx1112(opts)
      _ -> raise KeysError, keys: keys
    end
  end

  def tx1112([]) do
    internal_tx1112([])
  end

  def internal_tx1112(opts) do
    head = element(:Head, nil, [element(:TxCode, nil, 1112)])

    body =
      element(:Body, nil, [
        empty_element_or(:InstitutionID, opts),
        empty_element_or(:PaymentNo, opts),
        empty_element_or(:Amount, opts),
        empty_element_or(:PayerID, opts),
        empty_element_or(:PayerName, opts),
        empty_element_or(:SplitType, opts),
        empty_element_or(:SettlementFlag, opts),
        empty_element_or(:Usage, opts),
        empty_element_or(:Remark, opts),
        empty_element_or(:Note, opts),
        empty_element_or(:NotificationURL, opts)
      ])

    element(:Request, %{version: 2.0}, [head, body])
  end

  defp empty_element_or(name, opts) when is_atom(name) do
    case Keyword.get(opts, name) do
      nil -> element(name, nil)
      value -> element(name, nil, value)
    end
  end
end

