-module(float_to_binary).  
-export([float_to_bin/1]).  
-include("common.hrl").
  
float_to_bin(Float) when Float >= 0 ->  
    % 将浮点数转换为科学记数法形式，并获取系数和指数  
    {Mantissa, Exponent} = float_to_scientific(Float),  
    % 计算IEEE 754的指数部分（加上偏移量1023并转换为二进制）  
    ExpBin = integer_to_binary(Exponent + 1023, 11),  
    % 将尾数部分转换为二进制（去掉科学记数法的小数点）  
    MantissaBin = float_fraction_to_binary(Mantissa),  
    % 组合符号位（假设为正，所以为0）、指数和尾数部分  
    <<"0", ExpBin/binary, MantissaBin/binary>>;  
float_to_bin(Float) when Float < 0 ->  
    % 对于负数，可以调用正数的处理逻辑，并在最前面加上符号位'1'  
    <<"1", (float_to_bin(-Float))/binary>>.  
  
% 辅助函数：将浮点数转换为科学记数法形式  
float_to_scientific(Float) ->  
    % 此处为简化实现，不考虑精度问题  
    {Fraction, Exponent} = find_scientific(Float, 0),  
    {Fraction, Exponent}.  
  
% 递归查找科学记数法形式  
find_scientific(Float, Exponent) when Float < 1 ->  
    find_scientific(Float * 2, Exponent - 1);  
find_scientific(Float, Exponent) when Float >= 2 ->  
    find_scientific(Float / 2, Exponent + 1);  
find_scientific(Float, Exponent) ->  
    {Float, Exponent}.  
  
float_fraction_to_binary(Fraction) ->  
    % 设置默认的累加器和精度  
    DefaultAcc = <<>>,  
    DefaultPrecision = 52, % 例如，使用双精度浮点数的尾数位数  
    float_fraction_to_binary(Fraction, DefaultAcc, DefaultPrecision).  

float_fraction_to_binary(Fraction, Acc, 0) ->  
    Acc;  
float_fraction_to_binary(Fraction, Acc, Precision) ->  
    if Fraction * 2 >= 1 ->  
        NextFraction = (Fraction * 2) - 1,  
        NextAcc = <<Acc/binary, 1>>, % 或者使用 <<Acc/binary, 1:1>> 如果需要明确指定位宽  
        float_fraction_to_binary(NextFraction, NextAcc, Precision - 1);  
    true ->  
        NextFraction = Fraction * 2,  
        NextAcc = <<Acc/binary, 0>>, % 或者使用 <<Acc/binary, 0:1>>  
        float_fraction_to_binary(NextFraction, NextAcc, Precision - 1)  
    end.
  
integer_to_binary(Int, Length) ->  
    <<Int:Length>>.
-compile({no_auto_import,[integer_to_binary/2]}).