defmodule Dockexir.HTTPTest do
  use ExUnit.Case
  import Mock
  alias Dockexir.HTTP

  @resource "/fake/resource"

  test ".get should send a GET request" do
    with_mock :hackney, mocks() do
      {:ok, 200, _, _} = HTTP.get(@resource)
      assert called :hackney.send_request(:conn, {:get, @resource, [{:host, :localhost}], ""})
    end
  end

  test ".post should send a POST request" do
    with_mock :hackney, mocks() do
      {:ok, 200, _, _} = HTTP.post(@resource, :body)
      assert called :hackney.send_request(:conn, {:post, @resource, [{:host, :localhost}], :body})
    end
  end

  test ".put should send a PUT request" do
    with_mock :hackney, mocks() do
      {:ok, 200, _, _} = HTTP.put(@resource, :body)
      assert called :hackney.send_request(:conn, {:put, @resource, [{:host, :localhost}], :body})
    end
  end

  test ".delete should send a DELETE request" do
    with_mock :hackney, mocks() do
      {:ok, 200, _, _} = HTTP.delete(@resource, :body)
      assert called :hackney.send_request(:conn, {:delete, @resource, [{:host, :localhost}], :body})
    end
  end

  defp mocks do
    [connect: fn(Dockexir.UnixSocket, "/var/run/docker.sock", 0) -> {:ok, :conn} end,
     send_request: fn(_, _) -> {:ok, 200, :headers, :body} end,
     body: fn(_) -> {:ok, "{}"} end]
  end

end
