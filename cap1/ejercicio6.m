1;

# Genere una señal compleja del tiempo y grafiquela en 3 dimensiones..
t = 0:0.01:2*pi*4;
x = sin(t);
y = cos(t);

plot3(t, x, y)
