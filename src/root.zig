const std = @import("std");
const testing = std.testing;

// Jogo de Jokenpô
// PlayerA e PlayerB escolhem entre Pedra, Papel, Tesoura
// Calcular o resultado da rodada com base na regra:
// - Pedra empata Pedra.
// - Pedra perde Papel.
// - Pedra ganha Tesoura.

// - Papel ganha Pedra.
// - Papel empata Papel.
// - Papel perde Tesoura.

// - Tesoura perde Pedra.
// - Tesoura ganha Papel.
// - Tesoura empata Tesoura.

const Input = enum { Pedra, Papel, Tesoura };
const Result = enum { Perde, Empate, Ganha };
const WinnerResult = enum { Empate, PlayerA, PlayerB };
const ErrorNotImplemented = error{};
const Error = error{UserInput};

fn calcularResultadoRodada(playerA: Input, playerB: Input) Result {
    return switch (playerA) {
        .Pedra => switch (playerB) {
            .Pedra => Result.Empate,
            .Papel => Result.Perde,
            .Tesoura => Result.Ganha,
        },
        .Papel => switch (playerB) {
            .Pedra => Result.Ganha,
            .Papel => Result.Empate,
            .Tesoura => Result.Perde,
        },
        .Tesoura => switch (playerB) {
            .Pedra => Result.Perde,
            .Papel => Result.Ganha,
            .Tesoura => Result.Empate,
        },
    };
}

test "Dado que PlayerA colocou Pedra e PlayerB colocou Pedra resultado é Empate" {
    const inputPlayerA = Input.Pedra;
    const inputPlayerB = Input.Pedra;

    const resultado = calcularResultadoRodada(inputPlayerA, inputPlayerB);

    // std.debug.print("resultado ==>> {}\n", .{resultado});

    try testing.expectEqual(Result.Empate, resultado);
}

test "Dado que PlayerA colocou Pedra e PlayerB colocou Papel resultado é Perde" {
    const inputPlayerA = Input.Pedra;
    const inputPlayerB = Input.Papel;

    const resultado = calcularResultadoRodada(inputPlayerA, inputPlayerB);

    // std.debug.print("resultado ==>> {}\n", .{resultado});

    try testing.expectEqual(Result.Perde, resultado);
}

test "Dado que PlayerA colocou Pedra e PlayerB colocou Tesoura resultado é Ganha" {
    const inputPlayerA = Input.Pedra;
    const inputPlayerB = Input.Tesoura;

    const resultado = calcularResultadoRodada(inputPlayerA, inputPlayerB);

    // std.debug.print("resultado ==>> {}\n", .{resultado});

    try testing.expectEqual(Result.Ganha, resultado);
}

test "Dado que PlayerA colocou Papel e PlayerB colocou Pedra resultado é Ganha" {
    const inputPlayerA = Input.Papel;
    const inputPlayerB = Input.Pedra;

    const resultado = calcularResultadoRodada(inputPlayerA, inputPlayerB);

    // std.debug.print("resultado ==>> {}\n", .{resultado});

    try testing.expectEqual(Result.Ganha, resultado);
}

test "Dado que PlayerA colocou Papel e PlayerB colocou Papel resultado é Empate" {
    const inputPlayerA = Input.Papel;
    const inputPlayerB = Input.Papel;

    const resultado = calcularResultadoRodada(inputPlayerA, inputPlayerB);

    // std.debug.print("resultado ==>> {}\n", .{resultado});

    try testing.expectEqual(Result.Empate, resultado);
}

test "Dado que PlayerA colocou Papel e PlayerB colocou Tesoura resultado é Perde" {
    const inputPlayerA = Input.Papel;
    const inputPlayerB = Input.Tesoura;

    const resultado = calcularResultadoRodada(inputPlayerA, inputPlayerB);

    // std.debug.print("resultado ==>> {}\n", .{resultado});

    try testing.expectEqual(Result.Perde, resultado);
}

test "Dado que PlayerA colocou Tesoura e PlayerB colocou Pedra resultado é Perde" {
    const inputPlayerA = Input.Tesoura;
    const inputPlayerB = Input.Pedra;

    const resultado = calcularResultadoRodada(inputPlayerA, inputPlayerB);

    // std.debug.print("resultado ==>> {}\n", .{resultado});

    try testing.expectEqual(Result.Perde, resultado);
}

test "Dado que PlayerA colocou Tesoura e PlayerB colocou Papel resultado é Ganha" {
    const inputPlayerA = Input.Tesoura;
    const inputPlayerB = Input.Papel;

    const resultado = calcularResultadoRodada(inputPlayerA, inputPlayerB);

    // std.debug.print("resultado ==>> {}\n", .{resultado});

    try testing.expectEqual(Result.Ganha, resultado);
}

test "Dado que PlayerA colocou Tesoura e PlayerB colocou Tesoura resultado é Empate" {
    const inputPlayerA = Input.Tesoura;
    const inputPlayerB = Input.Tesoura;

    const resultado = calcularResultadoRodada(inputPlayerA, inputPlayerB);

    // std.debug.print("resultado ==>> {}\n", .{resultado});

    try testing.expectEqual(Result.Empate, resultado);
}

pub fn jokenpo(inputPlayerA: u8, inputPlayerB: u8) WinnerResult {
    // std.debug.print("RESULTADO ==>> {!d} {!d}\n", .{ inputPlayerA, inputPlayerB });:A
    const playerA = parse_input(inputPlayerA);
    // std.debug.print("A: {any}\n", .{playerA});
    const playerB = parse_input(inputPlayerB);
    // std.debug.print("B: {any}\n", .{playerB});

    const resultado = calcularResultadoRodada(playerA, playerB);
    return switch (resultado) {
        Result.Empate => WinnerResult.Empate,
        Result.Ganha => WinnerResult.PlayerA,
        Result.Perde => WinnerResult.PlayerB,
    };
}

fn parse_input(input: u8) Input {
    return switch (input) {
        1 => Input.Pedra,
        2 => Input.Papel,
        3 => Input.Tesoura,
        else => Input.Pedra,
    };
}

test "User INPUT" {
    std.debug.print("\n\nTESTES {s}\n\n", .{"User INPUT"});

    var r = jokenpo(1, 1);
    // std.debug.print("{any}", .{r});
    try testing.expectEqual(WinnerResult.Empate, r);

    r = jokenpo(1, 3);
    try testing.expectEqual(WinnerResult.PlayerA, r);

    r = jokenpo(1, 2);
    try testing.expectEqual(WinnerResult.PlayerB, r);
}
