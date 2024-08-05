# chess# Chess Game

A Ruby-based terminal chess game featuring a full implementation of standard chess rules and piece movements. This project includes player management, game state persistence, and colorful terminal output.

## Features

- Play new games or load saved games
- Standard chess pieces with movement and validation
- Colorful terminal display for board and pieces
- Automatic game saving on interruption

## Installation

Clone the repository and navigate to the project directory:

```sh
git clone git@github.com:andrecosta90/chess.git
cd chess
```

## Usage

Run the game with:
```sh
ruby lib/chess.rb
```
Follow the on-screen prompts to start a new game or load a saved game. Use terminal commands to make moves and view the game board.

## Testing

Run the game with:
```sh
rspec
```

## Upcoming Features

- **En Passant**: A special pawn capture move.
- **Castling**: A move involving the king and a rook.
- **Basic AI Computer Player**: A random-move AI opponent.
