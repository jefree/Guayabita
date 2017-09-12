defmodule Guayabita do

  defmodule Game do
    defstruct pot: 0, players: %{}
  end

  defmodule Player do
    defstruct pot: 0
  end

  defmodule Logic do
    def roll_dice do
      :rand.uniform(6)
    end

    def bet_result(bet, second, first) do
      case bet do
        :greater ->
          if second > first , do: :win, else: :lose
        :lesser ->
          if second < first , do: :win, else: :lose
      end
    end

    def game_after_player_bet(game, nickname, amount, bet, second, first) do
      result = bet_result(bet, second, first)

      newPlayer = game.players[nickname]
        |> update_player_pot(result, amount)

      %Game{ game | players: Map.put(game.players, nickname, newPlayer) }
        |> update_game_pot(result, amount)
    end

    def update_player_pot(player, result, amount) do
      case result do
        :win ->
          %Player{ player | pot: player.pot + amount }
        :lose ->
          %Player{ player | pot: player.pot - amount }
      end
    end

    def update_game_pot(game, result, amount) do
      case result do
        :win ->
          %Game{ game | pot: game.pot - amount }
        :lose ->
          %Game{ game | pot: game.pot + amount }
      end
    end
  end
end
