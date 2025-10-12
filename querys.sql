--Nivel 0
	--1
		select * from bandas;

	--2
		select nombre, pais_origen

	--3
		select nombre, fecha_creacion from bandas
		order by fecha_creacion desc;

	--4
		select nombre, pais_origen from bandas
		where genero = 'Rock'
	
	--5
		select * from albumes;
	
	--6
		select nombre, duracion from albumes
		order by nombre asc;
	
	--7
		select ranking, nombre from albumes a 
		order by ranking asc;
	
	--8
		select nombre, duracion from canciones 
		order by duracion desc;
	
	--9
		select nombre, fecha from conciertos
		order by fecha asc;
	
--Nivel 1
	--1
		select nombre, pais_origen from bandas b 
		where b.cant_integrantes = 5;
	
	--2
		select nombre, duracion from albumes a
		where a.duracion > 40
		order by duracion asc;
	
	--3
		select nombre, duracion from canciones c 
		where c.duracion >= 3
		order by duracion asc;
	
	--4
		select nombre, fecha from conciertos cn
		where pais = 'Argentina';
	
	--5
		select nombre, ranking 
		from (select nombre, ranking 
		from albumes a 
		order by a.ranking asc
		limit 7) as top7
		order by nombre asc;
	
--Nivel 2
	--1
		select nombre, ranking 
		from (select nombre, ranking
			from albumes a 
			order by a.ranking desc
			limit 5) as top5peores
		order by ranking desc;

	--2
		select a.nombre
		from albumes a
		join bandas b on a.banda_id  = b.id  
		where b.nombre ='The Beatles';
			
	--3
		select b.nombre 
		from bandas b
			join albumes a on b.id = a.banda_id
			where a.lanzamiento <= 1980
			group by b.nombre;
	--4
		select nombre, fecha
		from conciertos c
		where c.fecha < 2010;
	
	
	--5
		select sum(c.duracion) as duracion_total
		from canciones c
			join bandas b on c.banda_id = b.id
			where b.nombre = 'Queen';
	
	--6
		select sum(a.duracion) as duracion_total
		from albumes a
			join bandas b on a.banda_id = b.id 
			where b.nombre = 'The Rolling Stones';
		
	--7
		select cn.nombre 
		from conciertos_musicos cm 
			join bandas b on b.id = cm.banda_id 
			join conciertos cn on cn.id = cm.concierto_id 
		where b.nombre = 'Dire Straits';
	
	--8
		select b.nombre
		from bandas b 
			join albumes a on a.banda_id = b.id 
			where a.duracion < 40
		group by b.nombre ;
	
--Nivel 3
	
	--1
		select b.nombre as banda
		from bandas b 
			join albumes a on b.id = a.banda_id 
			where a.duracion > 50
		group by b.nombre ;
	
	--2
		select c.nombre
		from canciones c 
			join albumes a on a.id = c.album_id 
		where a.lanzamiento > 2000;
	
		SELECT 
		    a.nombre AS album,
		    c.nombre AS cancion
		FROM canciones c
		INNER JOIN albumes a ON c.album_id = a.id
		WHERE a.lanzamiento > 2000
		ORDER BY a.nombre ASC, c.nombre DESC;
	
	--3
		select  b.nombre
		from bandas b
		join canciones c on b.id = c.banda_id 
		where b.cant_integrantes < 5 and 
			b.genero = 'Rock Alternativo'
		group by b.nombre
		having MIN(c.duracion) >= 4;
	
	--4
		select c.nombre, count(cm.banda_id) as cantidad_bandas
		from conciertos c
		join conciertos_musicos cm on cm.concierto_id = c.id 
		group by c.id, c.nombre 
		order by cantidad_bandas desc
		limit 1;
	
	--5
		select a.nombre
		from albumes a
		join bandas b on a.banda_id = b.id
		join conciertos_musicos cm on b.id = cm.banda_id
		join conciertos c on c.id = cm.concierto_id 
		where c.pais = 'Argentina'
		group by a.id
		order by a.ranking;
	
	--6
		SELECT b.nombre, COUNT(c.id) AS cantidad_canciones
		FROM bandas b
		JOIN canciones c ON b.id = c.banda_id
		GROUP BY b.id, b.nombre
		ORDER BY cantidad_canciones DESC;
		
--Nivel 4
	
	--1 
		select a.nombre, b.nombre, a.lanzamiento 
		from albumes a 
		join bandas b on a.banda_id = b.id
		where a.lanzamiento = (
			select min(a2.lanzamiento)
			from albumes a2
			where a2.banda_id = a.banda_id
		);
	
	--2
		select round(avg(b.cant_integrantes), 2) as promedio_integrantes, b.genero
		from bandas b
		group by genero
		;
	
	--3
		select b.nombre
		from bandas b
		where not exists (
			
			select 1
			from conciertos c
			where c.pais = 'Argentina'
			and not exists (
				
				select 1
				from conciertos_musicos cm
				where c.id = cm.concierto_id
				and cm.banda_id = b.id 
			)
		);
	--4
		select b.nombre, round(avg(c.duracion), 2) as promedio_duracion
		from bandas b
		join canciones c on b.id = c.banda_id 
		group by b.id 
		having avg(c.duracion)>5;
	
	-------------------------------
		select nombre, lanzamiento
		from albumes a 
		where a.lanzamiento > 2000;
		select * from conciertos cn; 
		select * from conciertos_musicos cm;
		select * from bandas b;
		select * from canciones c;
		select * from albumes a;
		