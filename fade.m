function v = fade (v, fade_in_samples, fade_out_samples)
    % fade in
    fade_in_amplitudes = linspace(0, 1, fade_in_samples);
    v(1:fade_in_samples) = v(1:fade_in_samples) .* fade_in_amplitudes;
    
    % fade out
    fade_out_amplitudes = linspace(1, 0, fade_out_samples);
    v(end-fade_out_samples+1:end) = v(end-fade_out_samples+1:end) .* fade_out_amplitudes;
end
