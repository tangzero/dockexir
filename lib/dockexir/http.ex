defmodule Dockexir.HTTP do
  @moduledoc ~s"""
  
  """

  def get(path) do
    send_request({:get, path, ""})
  end

  def post(path, body) do
    send_request({:post, path, body})
  end

  def put(path, body) do
    send_request({:put, path, body})
  end

  def delete(path, body) do
    send_request({:delete, path, body})
  end

  defp send_request(request) do
    case connect() do
      {:ok, conn} -> send_request(conn, request)
      {:error, reason} -> {:error, reason}
    end
  end

  defp send_request(conn, {method, path, body}) do
    request = {method, path, [{:host, :localhost}], body}
    case :hackney.send_request(conn, request) do
      {:ok, code, headers, body} ->
        case parse_body(body) do
          {:ok, data} -> {:ok, code, headers, data}
          {:error, reason} -> {:error, reason}
        end
      {:error, reason} -> {:error, reason}
    end
  end

  defp parse_body(body) do
    case :hackney.body(body) do
      {:ok, content} -> Poison.decode(content)
      {:error, reason} -> {:error, reason}
    end
  end

  defp connect do
    :hackney.connect(Dockexir.UnixSocket, "/var/run/docker.sock", 0)
  end

end
