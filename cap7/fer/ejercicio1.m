1;
clear all;
x = rand(1,1000)-0.5;
a = [1 -0.3 0.4 -0.2];
y = filter([1],a,x);
r = autocov(y);
[A,E] = levinsonDurbin(r,3);

A
E
pause;
