%% Lab 5 Part 1

%%
%
clear

%% 1.1 - Definition: What is the FFT?
%

%%
% FFT is an acronym for the Fast Fourier Transform, an algorithm that 
% computes the discrete Fourier transform (DFT) of a discrete-time signal. 
% In other words, the FFT takes a discrete-time signal and extracts 
% important frequency domain information from that signal. It is considered
% "fast" because its computational complexity is far less than that of the 
% DFT, the Discrete Fourier Transform (see 
% https://en.wikipedia.org/wiki/Fast_Fourier_transform). In this lab, we 
% won?t care about the mechanics of the algorithm (hurrah!); we are simply 
% concerned with how to use the FFT function in MATLAB to determine 
% frequency domain information of signals. IMPORTANT: The FFT function 
% performs the DFT of a signal; the FFT is specific to an input signal 
% with length 2^n, but the FFT function in MATLAB can be used for input 
% signals that do not meet this criteria: this just performs a DFT (see 
% help fft for more information). The two terms are used interchangeably 
% throughout the lab.

%% 1.2 - Background: How does the FFT "Read" Frequency Information?
%

%%
% The FFT utilizes a series of sinusoidal basis signals of varying 
% frequency. The FFT determines how closely the input signal "matches"
% these basis signals, and outputs a vector of complex numbers - one for 
% each iteration of the algorithm. In this lab, we will call these complex 
% measurements frequency bins, or simply bins.

%%
% Because the outputs of the FFT are complex, we need an easier way to 
% visualize them. Simply plotting the vector of frequency bins will result 
% in a complicated jumble of vectors in the complex plane. Therefore, we 
% "read" the results of the FFT by plotting the magnitude spectrum of the 
% frequency bins. The higher the magnitude of the frequency bin, the higher
%  the correlation between the input signal and a sinusoid of that 
% frequency. Therefore, the magnitude spectrum should spike at regions 
% where the frequency of the sinusoidal basis signals match the input 
% signal. Recall that any signal can be expressed as the sum of sinusoids 
% of different frequencies. Consequently, the FFT is an extremely powerful 
% tool because it can help us decompose a complicated discrete-time signal 
% into its sinusoidal components.

%% 1.3 - Exercise: Decomposing Signals into Sinusoids
%

img = imread("5.1.1.3.jpg");
image(img);

%% 1.4 - FFT of a Single Sinusoid with Integer Frequency
%

%%
% Plot the continuous-time frequency spectrum of this signal by 
% hand.

img = imread("5.1.1.4.jpg");
image(img);

%%
% 1.4.1
% Define the variable fs for the sampling frequency, and assign it 1000
% samples/second.

fs = 1000;

%%
% 1.4.2
% Construct a time vector using this sampling frequency that is exactly
% 1500 samples long, starting at zero.

tt = 0:1/1000:1/1000*1499;

%%
% 1.4.3
% Define x(t) , the sinusoid described above, as the vector x.

xx = cos(2*pi * 50 * tt + 0.25*pi);

%%
% 1.4.4
% Run the fft() function on x (see help fft ).

XX = fft(xx);

%%
% 1.4.5

%%
% 1.4.5.1

magX = abs(XX);
plot(magX)

%%
% 1.4.5.2
% Compare this plot to your continuous-time spectrum. Question: What?s
% different about it?

%%
% This is similar to my continuous-time spectrum as there are two lines,
% one representing -50 Hz and one representing 50 Hz. However, the
% magnitude spectrum is different as the magnitude of these lines are much
% larger.

%%
% 1.4.5.3

maxValue = max(magX)

%%
% Question: What is the index corresponding to the left peak?

maxValueIndexes = find(magX == maxValue);
maxValueIndexes(1)

%%
% Question: What is the value of the magnitude spectrum everywhere else?

%%
% Approximately zero.

magX(maxValueIndexes(1)-1)

%%
% 1.4.5.4

%%
% The result of the Fourier transform of a sampled signal goes into
% frequency bins that correspond to the normalized radian frequency. Our
% convention thus far has been to draw magnitude spectra from -pi to pi.
% The FFT function, however, returns frequency bins ranging from 0 to 2*pi.

%%
% Plot FFT output against normalized radian frequency.

ww = 0:(2*pi/length(XX)):(2*pi-1/length(XX));
plot(ww,abs(XX));

%%
% 1.4.5.5

%%
% The fftshift() function (see help fftshift ) is a way to "fix" the output
% of the FFT function in order to make it range from ?pi to pi.

%%
% Plot the shifted FFT output against normalized radian frequency:

ww = -pi:(2*pi/length(XX)):(pi-1/length(XX));
plot(ww,abs(fftshift(XX)));

%%
% 1.4.5.6

%%
% The normalized radian frequency is related to the frequency in Hz by the
% sampling frequency and a factor of 2*pi.

%%
% Plot the FFT of X against the Hertz frequencies of the bins. 

ww = -pi:(2*pi/length(XX)):(pi-1/length(XX));
ff = ww .* (fs/2) ./ (2*pi);
plot(ff, abs(XX));

%%
% 1.4.6

%%
% 1.4.7

%% 1.5 - FFT of Multiple Sinusoids with Integer Frequency
%