defmodule ObscuriaWeb.PuzzlesLive.Index do
  use ObscuriaWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, word: "Obscuria")}
  end

  def handle_params(params, _url, socket) do
    {:noreply, assign(socket, other_word: params["word"])}
  end
end
