% morse_encode.m
% (c) 2023-03-05 Pete Laric / www.PeteLaric.com
% A simple MATLAB/Octave script to automatically generate Morse code audio
% from text.  The tone frequency and data rate are fully adjustable.  The
% resulting audio can be played, saved to file, or both.  Enjoy!

clear all
clc

%message = 'The quick brown fox jumped over the lazy dog.'
%message = 'And I will strike down upon thee with great vengeance and furious anger those who attempt to poison and destroy my brothers. And you will know I am the Lord when I lay my vengeance upon you.'
message = input('message: ', "s");

sample_rate = 44100
output_filename = 'morse.wav'
f = 440
phi = 0
amplitude = 0.5

dit_length_seconds = 0.05
fade_samples = 3
fade_in_samples = fade_samples
fade_out_samples = fade_samples
dah_length_seconds = 3 * dit_length_seconds
basic_pause_seconds = dit_length_seconds %pause between dit and dah within letter
letter_pause_seconds = 2 * dit_length_seconds
word_pause_seconds = 7 * dit_length_seconds
leading_silence_seconds = dit_length_seconds %takes a sec for audio player to boot up
trailing_silence_seconds = dit_length_seconds

% sounds of silence
basic_silence = zeros(1, round(basic_pause_seconds*sample_rate));
letter_pause_silence = zeros(1, round(letter_pause_seconds*sample_rate));
word_pause_silence = zeros(1, round(word_pause_seconds*sample_rate));
leading_silence = zeros(1, round(leading_silence_seconds*sample_rate));
trailing_silence = zeros(1, round(trailing_silence_seconds*sample_rate));

% dit sound
t = linspace(0,dit_length_seconds,dit_length_seconds*sample_rate);
dit_sound = amplitude * sin(2 * pi * f * t + phi);
dit_sound = fade(dit_sound, fade_in_samples, fade_out_samples);
% post-dit silence
%t = linspace(0,basic_pause_seconds,basic_pause_seconds*sample_rate)';
%post_dit_silence = zeros(basic_pause_seconds*sample_rate,1);
%dit_sound = [dit_sound; post_dit_silence];

% dah sound
t = linspace(0,dah_length_seconds,dah_length_seconds*sample_rate);
dah_sound = amplitude * sin(2 * pi * f * t + phi);
dah_sound = fade(dah_sound, fade_in_samples, fade_out_samples);
% post-dah silence
%t = linspace(0,basic_pause_seconds,basic_pause_seconds*sample_rate)';
%post_dah_silence = zeros(basic_pause_seconds*sample_rate,1);
%dah_sound = [dah_sound; post_dit_silence];

%message_sound = [dit_sound; dah_sound; dah_sound; dit_sound];

message_length = length(message)
morse_text = ' ';
for i=1:message_length

  c = toupper(message(i));
  switch c
    case ' '                              % space
      morse_text = [morse_text, ' '];
    case 'A'                              % letters
      morse_text = [morse_text, '.- '];
    case 'B'
      morse_text = [morse_text, '-... '];
    case 'C'
      morse_text = [morse_text, '-.-. '];
    case 'D'
      morse_text = [morse_text, '-.. '];
    case 'E'
      morse_text = [morse_text, '. '];
    case 'F'
      morse_text = [morse_text, '..-. '];
    case 'G'
      morse_text = [morse_text, '--. '];
    case 'H'
      morse_text = [morse_text, '.... '];
    case 'I'
      morse_text = [morse_text, '.. '];
    case 'J'
      morse_text = [morse_text, '.--- '];
    case 'K'
      morse_text = [morse_text, '-.- '];
    case 'L'
      morse_text = [morse_text, '.-.. '];
    case 'M'
      morse_text = [morse_text, '-- '];
    case 'N'
      morse_text = [morse_text, '-. '];
    case 'O'
      morse_text = [morse_text, '--- '];
    case 'P'
      morse_text = [morse_text, '.--. '];
    case 'Q'
      morse_text = [morse_text, '--.- '];
    case 'R'
      morse_text = [morse_text, '.-. '];
    case 'S'
      morse_text = [morse_text, '... '];
    case 'T'
      morse_text = [morse_text, '- '];
    case 'U'
      morse_text = [morse_text, '..- '];
    case 'V'
      morse_text = [morse_text, '...- '];
    case 'W'
      morse_text = [morse_text, '.-- '];
    case 'X'
      morse_text = [morse_text, '-..- '];
    case 'Y'
      morse_text = [morse_text, '-.-- '];
    case 'Z'
      morse_text = [morse_text, '--.. '];
    case '1'                                % numbers
      morse_text = [morse_text, '.---- '];
    case '2'
      morse_text = [morse_text, '..--- '];
    case '3'
      morse_text = [morse_text, '...-- '];
    case '4'
      morse_text = [morse_text, '....- '];
    case '5'
      morse_text = [morse_text, '..... '];
    case '6'
      morse_text = [morse_text, '-.... '];
    case '7'
      morse_text = [morse_text, '--... '];
    case '8'
      morse_text = [morse_text, '---.. '];
    case '9'
      morse_text = [morse_text, '----. '];
    case '0'
      morse_text = [morse_text, '----- '];
    case '.'                                % punctuation
      morse_text = [morse_text, '.-.-.- '];
    case ','
      morse_text = [morse_text, '--..-- '];
    case '?'
      morse_text = [morse_text, '..--.. '];
    case '!'
      morse_text = [morse_text, '-.-.-- '];
    otherwise
      morse_text = [morse_text, '? '];
  end

end

morse_text

message_sound = leading_silence;

morse_text_length = length(morse_text)
for i=1:morse_text_length
  
  m = morse_text(i);
  switch m
    case '.'
      message_sound = [message_sound, dit_sound, basic_silence];
    case '-'
      message_sound = [message_sound, dah_sound, basic_silence];
    case ' '
      message_sound = [message_sound, word_pause_silence];
  end
  
end

audio_buffer = [message_sound, trailing_silence];

player = audioplayer(audio_buffer, sample_rate)

% start the playback
play(player);

audiowrite(output_filename, audio_buffer, sample_rate);

% play generated audio file using audacity
%%%command = ['audacity ', output_filename, ' &']
%%%system(command)

% % pause the playback
% pause(player);
% 
% % resume the playback
% resume(player)


%disp('Press any key to stop player...')
%pause