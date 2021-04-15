defmodule CPCNSdk.TxTypeTest do
  use ExUnit.Case, async: true
  alias CPCNSdk.TxType

  describe "tx1112/1" do
    test "with empty keyword list" do
      xml_tuple =
        {:Request, %{version: 2.0},
         [
           {:Head, nil, [{:TxCode, nil, 1112}]},
           {:Body, nil,
            [
              {:InstitutionID, nil, nil},
              {:PaymentNo, nil, nil},
              {:Amount, nil, nil},
              {:PayerID, nil, nil},
              {:PayerName, nil, nil},
              {:SplitType, nil, nil},
              {:SettlementFlag, nil, nil},
              {:Usage, nil, nil},
              {:Remark, nil, nil},
              {:Note, nil, nil},
              {:NotificationURL, nil, nil}
            ]}
         ]}

      assert TxType.tx1112([]) == xml_tuple
    end

    test "with a PaymentNo value" do
      payment_no = 20_200_514

      xml_tuple =
        {:Request, %{version: 2.0},
         [
           {:Head, nil, [{:TxCode, nil, 1112}]},
           {:Body, nil,
            [
              {:InstitutionID, nil, nil},
              {:PaymentNo, nil, payment_no},
              {:Amount, nil, nil},
              {:PayerID, nil, nil},
              {:PayerName, nil, nil},
              {:SplitType, nil, nil},
              {:SettlementFlag, nil, nil},
              {:Usage, nil, nil},
              {:Remark, nil, nil},
              {:Note, nil, nil},
              {:NotificationURL, nil, nil}
            ]}
         ]}

      assert TxType.tx1112(PaymentNo: payment_no) == xml_tuple
    end

    test "error: when input a not support key" do
      assert_raise CPCNSdk.TxType.KeysError, "keys: [:not_support] not support", fn ->
        TxType.tx1112(not_support: 1)
      end
    end
  end
end
