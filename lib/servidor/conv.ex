defmodule Servidor.Conv do
  defstruct method: "", path: "", protocol: "", resp_body: "", status: nil

  def get_full_status(%Servidor.Conv{} = conv),
    do: "#{conv.protocol} #{conv.status} #{status_reason(conv.status)}"

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end
