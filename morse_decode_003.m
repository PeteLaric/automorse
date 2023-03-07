% morse_decode.m
% (c) 2023-03-06 Pete Laric / www.PeteLaric.com
% A simple MATLAB/Octave script to automatically decode Morse code from an
% audio recording.  This rough draft does not use machine learning, but
% rather a simple, methodical approach.  Neither the frequency of the tone,
% nor the data rate of the code, should affect the output in theory.  In
% practice, this is still a work in progress, so perfect results are not
% guaranteed.

clear all
clc

input_filename = 'LazyDog.wav'
%input_filename = 'Julius.wav'

%audiowrite(output_filename, audio_buffer, sample_rate);
[audio_buffer, sample_rate] = audioread(input_filename);

sample_rate

%%%player = audioplayer(audio_buffer, sample_rate)

% start the playback
%%%play(player);

%%%figure();
%%%plot(audio_buffer);

% analyze
audio_buffer_length = length(audio_buffer)

% 44100 = 1 sec @ 44.1 kHz
% 4410 = 0.1 sec
% 441 = 0.01 sec
window_size = 441
mads = zeros(1, audio_buffer_length-window_size);
for i=1:audio_buffer_length-window_size
  
  window = audio_buffer(i:i+window_size-1);
  window_mad = mad(window);
  mads(i) = window_mad;

end

%figure();
%plot(mads)

mad_max = max(mads)
logic_threshold = mad_max / 2

bool = mads > logic_threshold;

%figure();
%plot(bool);

% strip leading silence
bool_length = length(bool)
for i=1:bool_length
  if bool(i) > logic_threshold
    bool = bool(i:end); % crop leading silence
    break;
  end
end


% strip trailing silence
bool_length = length(bool)
for i=bool_length:-1:1
  if bool(i) > logic_threshold
    bool = bool(1:i); % crop trailing silence
    break;
  end
end

figure();
plot(bool);

% compute run lengths
bool_length = length(bool)
run_length = 0;
run_lengths = 0;
for i=2:bool_length
  if (bool(i) == bool(i-1))
    run_length = run_length + 1;
  else
    run_length %output run length
    run_lengths = [run_lengths, run_length];
    run_length = 0; %reset to zero
  end
end

% strip leading zero off run_lengths
run_lengths = run_lengths(2:end);  

% compute stats on run lengths
min_run_length = min(run_lengths)
max_run_length = max(run_lengths)
mean_run_length = mean(run_lengths)
std_run_length = std(run_lengths)

dit_length = min_run_length
half_dit_length = dit_length / 2

signal = 0;
for i=round(half_dit_length):dit_length:bool_length
  signal = [signal, bool(i)];
end

signal = signal(2:end);

% translate signal to morse
signal = [0, signal, 0];
signal_length = length(signal)
message_morse = ' ';
for i=3:signal_length
  total = sum(signal(i-2:i));
  c = ' ';
  if (total == 3)
    c = '-';
    message_morse = [message_morse, c];
    i = i + 2;
    if (i > signal_length)
      break;
    end
  elseif (total == 1) && (signal(i-1) == 1)
    c = '.';
    message_morse = [message_morse, c];
    i = i + 2;
    if (i > signal_length)
      break;
    end
  elseif (total == 0)
    c = ' ';
    message_morse = [message_morse, c];
  end
end

message_morse = message_morse(2:end);

message_morse

message_morse_length = length(message_morse);
rem = message_morse;
message_text = ' ';
for i=1:message_morse_length
  [tok, rem] = strtok(rem);
  %tok
  message_text = [message_text, morse2text(tok)];
  if (length(rem) == 0)
    break
  end
end
message_text = message_text(2:end);

message_text
