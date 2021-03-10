defmodule IslandsInterfaceWeb.Presence do
  use Phoenix.Presence,
    otp_app: :islands_interface_web,
    pubsub_server: IslandsInterface.PubSub
end
