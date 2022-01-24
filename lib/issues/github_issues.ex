defmodule Issues.GithubIssues do
  @user_agent  [ {"User-agent", "Elixir dave@pragprog.com"} ]

  @spec fetch(any, any) :: {:error, any} | {:ok, any}
  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  @spec issues_url(any, any) :: <<_::64, _::_*8>>
  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  @spec handle_response(
          {any,
           %{
             :body =>
               binary
               | maybe_improper_list(
                   binary | maybe_improper_list(any, binary | []) | byte,
                   binary | []
                 ),
             :status_code => any,
             optional(any) => any
           }}
        ) ::
          {:error,
           false
           | nil
           | true
           | binary
           | [false | nil | true | binary | list | number | {any, any, any} | map]
           | number
           | %{
               optional(atom | binary | {any, any, any}) =>
                 false | nil | true | binary | list | number | {any, any, any} | map
             }}
          | {:ok,
             false
             | nil
             | true
             | binary
             | [false | nil | true | binary | list | number | {any, any, any} | map]
             | number
             | %{
                 optional(atom | binary | {any, any, any}) =>
                   false | nil | true | binary | list | number | {any, any, any} | map
               }}
  def handle_response({ _, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_error(),
      body        |> Poison.Parser.parse!()
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_),   do: :error
end
