defmodule SchoolPortal.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :school_portal,
    error_handler: SchoolPortal.Auth.ErrorHandler,
    module: SchoolPortal.Auth.Guardian

    plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}


    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}


    plug Guardian.Plug.LoadResource, allow_blank: true
end
