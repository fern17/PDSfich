1;

x = 0:0.1:2;
y = 0:0.1:2;
n = length(x);
z = randn(n,n);
mesh(x,y,z);
hold on;
