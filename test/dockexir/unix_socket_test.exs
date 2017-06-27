defmodule Dockexir.UnixSocketTest.Macros do
  alias Dockexir.UnixSocket

  defmacro test_delegate(function, args) do
    quote do
      with_mock :hackney_tcp, [:unstick], [{unquote(function), fn(unquote_splicing(args)) -> :ok end}] do
        :ok = UnixSocket.unquote(function)(unquote_splicing(args))
      end
    end
  end
end

defmodule Dockexir.UnixSocketTest do
  use ExUnit.Case
  import Mock
  import Dockexir.UnixSocketTest.Macros
  alias Dockexir.UnixSocket

  test "should connect to a Unix socket" do
    with_mock :gen_tcp, [:unstick], [connect: fn({:local, '/var/run/docker.sock'}, _, _, _) -> {:ok, :socket} end] do
      {:ok, conn} = :hackney.connect(UnixSocket, "/var/run/docker.sock", 0)
      assert is_reference(conn)
      assert called :gen_tcp.connect(
        {:local, '/var/run/docker.sock'}, 0,
        [:binary, {:active, false}, {:packet, :raw}], 8000
      )
    end
  end

  test_delegate :send, [:socket, :data]
  test_delegate :recv, [:socket, :length, :timeout]
  test_delegate :close, [:socket]
  test_delegate :controlling_process, [:socket, :pid]
  test_delegate :setopts, [:socket, :opts]
  test_delegate :peername, [:socket]
  test_delegate :messages, [:socket]

end
