1;


# Genere una señal compleja del tiempo y grafiquela en 3 dimensiones..

r  = -10:0.1:10;
im = 10:0.1:-10;

for i=1:length(r)
	y(i)=r(i) + j*im(i);
end

disp(y);