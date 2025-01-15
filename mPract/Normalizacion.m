%Compute FT
z = fftshift(fft(x1000));
f = -fs/2: fs/(length(n1000)-1): fs/2 ;
%plot time domain
figure
subplot(2,1,1)
plot(t,x)
hold on;
grid on;
stem(t1000, x1000, 'filled', 'r', 'LineWidth', 2);
%plot freq domain
subplot(2,1,2);
plot(f,abs(z)); %normalization??
grid on;
xticks(-500:50:500);
xlim([-300 300]);