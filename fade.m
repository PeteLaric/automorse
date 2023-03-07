## Copyright (C) 2023 Guy Fawkes
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} fade (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Guy Fawkes <guyfawkes@vivobook>
## Created: 2023-03-05

function v = fade (v, fade_in_samples, fade_out_samples)
    % fade in
    fade_in_amplitudes = linspace(0, 1, fade_in_samples);
    v(1:fade_in_samples) = v(1:fade_in_samples) .* fade_in_amplitudes;
    
    % fade out
    fade_out_amplitudes = linspace(1, 0, fade_out_samples);
    v(end-fade_out_samples+1:end) = v(end-fade_out_samples+1:end) .* fade_out_amplitudes;
endfunction
