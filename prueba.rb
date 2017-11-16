continuar = true

while continuar
puts '-------------------------------------------------------------------'
puts ''
puts 'Ingrese una opción del menú:'
puts '(1) Nuevo archivo con Nombre de cada Alumno y su promedio de notas'
puts '(2) Inasistencias totales por cada alumno'
puts '(3) Alumnos aprobados'
puts '(4) Salir del Programa'
puts ''
puts '-------------------------------------------------------------------'

option = gets.chomp.to_i

case option
when 1
  file = File.open('datos.csv', 'r')
  notas = file.readlines
  file.close

  arreglo_totales = []

  notas.each do |line|
    alumno_y_sus_notas = line.split(', ')
    nombre = alumno_y_sus_notas[0]
    suma = alumno_y_sus_notas[1].to_i + alumno_y_sus_notas[2].to_i + alumno_y_sus_notas[3].to_i + alumno_y_sus_notas[4].to_i + alumno_y_sus_notas[5].to_i
    promedio = suma / (alumno_y_sus_notas.length - 1).to_f
    # nombre = 'Mai'
    # suma = 46
    arreglo_totales.push([nombre, promedio])
    # arreglo_totales = [['JP', 50], ['Mai', 46]]
  end

  file = File.open('promedios.txt', 'w')
  arreglo_totales.each do |alumno_con_promedio|
    file.puts "El promedio de #{alumno_con_promedio.first} es: #{alumno_con_promedio.last}"
  end
  puts 'Se ha creado un archivo llamado promedios.txt con los promedios de cada alumno'
  file.close
  # arreglo_totales = [['JP', 10], ['Mai', 7], [], []]

when 2
  file = File.open('datos.csv', 'r')
  notas = file.readlines
  file.close

  arreglo_asistencias = []

  notas.each do |line|
    alumno_y_sus_notas = line.split(', ').map { |w| w.chomp }
    # alumno_y_sus_notas = ["David", "9", "2", "5", "1", "1"]["Gonzalo", "10", "A"]
    nombre = alumno_y_sus_notas[0]
    # nombre = David Gonzalo Mai JP
    suma = 0
    alumno_y_sus_notas.each do |word|
      suma += 1 if word == 'A'
    end
    arreglo_asistencias.push([nombre, suma])
  end

  arreglo_asistencias.each do |alumnos_y_sus_asistencias|
    puts "#{alumnos_y_sus_asistencias.first} tuvo #{alumnos_y_sus_asistencias.last} inasistencias en el curso"
  end

when 3
  def aprobacion(minimo = 5)
    file = File.open('datos.csv', 'r')
    notas = file.readlines
    file.close
    arreglo_totales = []
    notas.each do |line|
      alumno_y_sus_notas = line.split(', ').map { |w| w.chomp }
      nombre = alumno_y_sus_notas[0]
      suma = alumno_y_sus_notas[1].to_i + alumno_y_sus_notas[2].to_i + alumno_y_sus_notas[3].to_i + alumno_y_sus_notas[4].to_i + alumno_y_sus_notas[5].to_i
      promedio = suma / (alumno_y_sus_notas.length - 1).to_f
      arreglo_totales.push([nombre, promedio])
    end
    arreglo_totales.each do |alumnos_con_promedio|
      if alumnos_con_promedio[1] > minimo
        puts "El alumno #{alumnos_con_promedio[0]} ha aprobado el curso con promedio #{alumnos_con_promedio[1]}"
      else
        puts "El alumno #{alumnos_con_promedio[0]} ha reprobado el curso con promedio #{alumnos_con_promedio[1]}"
      end
    end
  end

  aprobacion(4)

when 4
  continuar = false

else
  puts 'La opción ingresada no es válida. Favor intente nuevamente'

end
end
