const std = @import("std");
const root = @import("root.zig");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("===============\nBem-vindo ao jogo do Jokenpô\n===============\n\nDigite:\n    1 - Pedra\n    2 - Papel\n    3 - Tesoura.\n Ou 0 - Fechar\n\n", .{});
    try stdout.print("JOGADOR 'A' FAÇA SUA JOGADA: ", .{});
    const inputPlayerA = try ask_user(u8);

    try stdout.print("JOGADOR 'B' FAÇA SUA JOGADA: ", .{});
    const inputPlayerB = try ask_user(u8);

    const result = root.jokenpo(inputPlayerA, inputPlayerB);
    // std.debug.print("\n\n{any}\n\n", .{result});

    try stdout.print("\n\nO VENCEDOR FOI {any}\n\n", .{result});
}

fn ask_user(comptime number_type: type) !number_type {
    const stdin = std.io.getStdIn().reader();
    var buf: [10]number_type = undefined;

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |user_input| {
        return std.fmt.parseInt(number_type, user_input, 10);
    } else {
        return @as(number_type, 0);
    }
}
