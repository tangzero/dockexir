defmodule Dockexir.HTTP do

  def get(resource) do
    {:ok, conn} = connect()
    request = {:get, resource, [{:host, :localhost}], ""}
    {:ok, code, headers, body} = :hackney.send_request(conn, request)
    IO.puts code
    IO.inspect headers
    :hackney.body(body)
  end

  defp connect do
    :hackney.connect(Dockexir.UnixSocket, "/var/run/docker.sock", 0)
  end

end
