defmodule Dockexir.UnixSocket do

  defdelegate send(socket, data), to: :hackney_tcp
  defdelegate recv(socket, length, timeout), to: :hackney_tcp
  defdelegate close(socket), to: :hackney_tcp
  defdelegate controlling_process(socket, pid), to: :hackney_tcp
  defdelegate setopts(socket, opts), to: :hackney_tcp
  defdelegate peername(socket), to: :hackney_tcp
  defdelegate messages(socket), to: :hackney_tcp

  def connect(filename, port, opts, timeout) do
    opts = [:binary, {:active, false}, {:packet, :raw} | opts]
    :gen_tcp.connect({:local, filename}, port, opts, timeout)
  end

end
