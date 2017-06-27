defmodule Dockexir.UnixSocketTest do
  use ExUnit.Case, async: false
  import Mock
  alias Dockexir.UnixSocket

  test "should connect to a Unix socket" do
    with_mock :gen_tcp, [:unstick], [connect: fn({:local, '/var/run/docker.sock'}, _, _, _) -> {:ok, :socket} end] do
      {:ok, conn} = :hackney.connect(UnixSocket, "/var/run/docker.sock", 0)
      assert is_reference(conn)
    end
  end

  test ".send should delegates to :hackney_tcp" do
    with_mock :hackney_tcp, [:unstick], [send: fn(:socket, :data) -> :ok end] do
      :ok = UnixSocket.send(:socket, :data)
    end
  end

  test ".recv should delegates to :hackney_tcp" do
    with_mock :hackney_tcp, [:unstick], [recv: fn(:socket, :length, :timeout) -> :ok end] do
      :ok = UnixSocket.recv(:socket, :length, :timeout)
    end
  end

end
