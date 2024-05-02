package pu.fmi.cources;

import java.util.UUID;

import lombok.Data;

public class Game {
	
	private UUID gameId;
	private Player[][] board;
	
	private Player turn;
	
	public Game() {
		gameId = UUID.randomUUID();
		turn = Player.RED;
		board = new Player[6][7];
	}

	public UUID getGameId() {
		return gameId;
	}

	public void setGameId(UUID gameId) {
		this.gameId = gameId;
	}

	public Player[][] getBoard() {
		return board;
	}

	public void setBoard(Player[][] board) {
		this.board = board;
	}

	public Player getTurn() {
		return turn;
	}

	public void setTurn(Player turn) {
		this.turn = turn;
	}
}
