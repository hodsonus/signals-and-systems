%% Lab 3 Part 1

%% 1.1 - Frequency Response of the Four-Point Averager
%

%%
% 1.

%%
% Question 1: Using the Euler Formulas, show by hand that the frequency
% response for the 4-point running average operator is equivalent to the
% definition in the lab document.

img = imread("1.1.1.jpg");
image(img);

%%
% 2. Implement this equation directly in code and plot the magnitude and phase
% response of this filter.

ww = -pi:(2*pi/399):pi;
H = 1/4*(2*cos(0.5*ww) + 2*cos(1.5*ww)).*exp(-j*1.5*ww);
mag = abs(H);
ang = angle(H);

%%
%
plot(ww,mag);

%%
%
plot(ww,ang);

%%
% 3.

bb = ones(1,4) / 4;
aa = 1;
N = 400;

[HH,ww] = freekz(bb,aa,ww,'whole');
subplot(2,1,1), semilogy(ww,abs(HH));    %-- magnitude
subplot(2,1,2), plot(ww,angle(HH));

%% 1.2 - MATLAB find() function
%

b = ones(1,4) / 4;
w = -pi:pi/500:pi;
H = freekz(b,1,w);
index = find(abs(H) < 0.001)

%%
% Question 2: Does this match the frequency response that you plotted for
% the 4-point average?

%%
% Yes, it does, as you can see that the indexes occur at approximately 0,
% pi/2, 3*pi/2, and 2*pi. This matches the zeroes on the above plot.

index * pi/500

%% 1.3 - Nulling Filter
%

%%
% 1.

%%
% Design a filtering system that consists of the cascade of two FIR nulling
% filters that will eliminate the following input frequencies: w = 0.44*pi,
% and w = 0.7*pi. For this part, derive the filter coefficients of both
% nulling filters. Submit necessary code, and plots of the magnitude and
% phase responses of both filters, along with the cascaded system.

%%
% Filter 1.

wn = 0.44*pi;
b0 = 1;
b1 = -2*cos(wn);
b2 = 1;

filt1 = [b0,b1,b2];
ww = -pi:pi/500:pi;
filt1H = freekz(filt1,1,ww);

subplot(2,1,1), semilogy(ww,abs(filt1H)); %-- magnitude
subplot(2,1,2), plot(ww,angle(filt1H));

%%
% Filter 2.

wn = 0.7*pi;
b0 = 1;
b1 = -2*cos(wn);
b2 = 1;

filt2 = [b0,b1,b2];
ww = -pi:pi/500:pi;
filt2H = freekz(filt2,1,ww);

subplot(2,1,1), semilogy(ww,abs(filt2H)); %-- magnitude
subplot(2,1,2), plot(ww,angle(filt2H));

%%
% Cacaded filter.

ww = -pi:pi/500:pi;
casc = conv(filt1,filt2);
cascH = filt1H .* filt2H;

subplot(2,1,1), semilogy(ww,abs(cascH)); %-- magnitude
subplot(2,1,2), plot(ww,angle(cascH));

%%
% 2.

%%
% Generate an input signal that is the sum of three sinusoids

n = 0:1:149;
xx = 5*cos(0.3*pi*n) + 22*cos(0.44*pi*n - pi/3) + 22*cos(0.7*pi*n - pi/4);
clf
plot(n,xx)

%%
% 3.

clf
out = conv(xx,casc);

%%
% 4.

plot(out(1:50));

%%
% Determine (by hand) the exact mathematical formula (magnitude, 
% phase and frequency) for the output signal for n ? 5.

pg1 = imread("1.3.4 pg1.jpg");
image(pg1);
%%
%
pg2 = imread("1.3.4 pg2.jpg");
image(pg2);

%%
% 5.

%%
% Plot the expected output of the cascaded filter and compare it to the
% plot obtained in 1.3.4 to show that it matches the filter output over the
% range 5 <= n <= 50 .

%%
% The above plot is the expected output of the cascaded filter in the range
% 5 <= n <= 50. The below plot is the actual output of the cascaded filter
% in the range 5 <= n <= 50. As you can see, in this sample range, they are
% literally identical.

yy = 9.165 * cos(0.3*pi*n - 1.885);
clf
subplot(2,1,1), plot(yy(5:50))
subplot(2,1,2), plot(out(5:50))

%%
% 6.

%%
% Question 3: Explain why the output signal is different for the first few
% points. How many "start-up" points are found? How is this number related
% to the lengths of the filters designed previously?

%%
% The reason that the output signal is different for the first few points
% is because in reality, there is also a transient response from an FIR
% filter and not just the theoretical steady-state response that was
% obtained from my derivation. This transient response period is known as
% the settling period. For a length N filter we expect to find N-1
% samples in the transient response. Since our cascaded filter is of
% length 5 (3 + 3 - 1 = 5), then we expect the first 4 samples to be the
% transient response. Thus, when we look from 5 samples onwards, they are
% the same.