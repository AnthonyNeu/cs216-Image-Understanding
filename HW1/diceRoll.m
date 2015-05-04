function [result] = diceRoll()
%simualte the roll of a six sided dice
result = floor(rand(1) * 6) + 1;
