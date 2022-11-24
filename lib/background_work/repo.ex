defmodule BackgroundWork.Repo do
  use Ecto.Repo,
    otp_app: :background_work,
    adapter: Ecto.Adapters.Postgres
end
