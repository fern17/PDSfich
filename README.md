Procesamiento Digital de Señales 2012 - UNL FICH
========================
Lenguaje Utilizado: Octave.

Developers/Collaborators
---------------

* **Benassi, Damián.** 
* **Nellmeldin, Fernando.**
* **Peyregne, Mariano.**

MultiPlot Example:
---------------

clf;
clear plot;

figure(1);
hold on;
plot(xd,yd, 'b');
hold on;
plot(x,y, 'g');

legend('Muestreada', 'Original')

