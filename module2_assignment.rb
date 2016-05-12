#Implement all parts of this assignment within (this) module2_assignment2.rb file
class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number #Solo getters
  #highest_wf_count   : Cantidad maxima en una linea
  #highest_wf_words   : Arreglo de palabras mas repetidas
  #content            : Contenido de la linea a analizar
  #line_number        : Numero de linea a analizar

  def initialize(contenido, num_linea)
    @content = contenido
    @line_number = num_linea
    self.calculate_word_frequency(contenido)    
  end

  def calculate_word_frequency(contenido)
    repetidos = Hash.new(0)
    #Dividiendo split
      contenido.split(" ").each do |palabra|
        repetidos[palabra.downcase] += 1 #Acumuladores de cada palabra, con hash en minuscula la palabra
      end
      # .values : array de cada item del hash
      #http://ruby-doc.org/core-2.2.0/Hash.html#method-i-values
      @highest_wf_count = repetidos.values.max
      # selecciono un Hash tal q su valor max y almaceno sus claves (la palabra)
      @highest_wf_words = repetidos.select do |k, cantidad|
        cantidad == @highest_wf_count #valor de verdad
      end
      #Modifico el array y obtengo sus claves (Las palabras)
      @highest_wf_words=@highest_wf_words.keys
  end
end

#  Implement a class called Solution.
class Solution
  attr_reader :highest_count_across_lines, :highest_count_words_across_lines, :analyzers #solo getters
  #highest_count_across_lines       : Mayor Contador de linea   
  #highest_count_words_across_lines : Arreglo de Objetos LineAnalizer Mayor numero de palabras entre lineas
  #analyzers                        : Arreglo de Objetos LineAnalizer a analizar
  def initialize()
    @analyzers = Array.new()
  end
  #Lectura del file 'test.txt' a un array de objetos LineAnalyzer
  def analyze_file()
    lineas = File.foreach("test.txt")
    lineas.each_with_index do |linea, pos| 
      @analyzers.push(LineAnalyzer.new(linea, pos)) 
    end
  end
  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = 0
    @highest_count_words_across_lines = Array.new()

    @analyzers.each do |l|
      if @highest_count_across_lines<l.highest_wf_count
        @highest_count_across_lines=l.highest_wf_count #almaceno la cantidad mas repetida de veces
      end      
    end
    #uso otro select para ver cuales son esas palabras repetidas (Objetos de LineAnalizer)
    @analyzers.select do |obj|
      if(obj.highest_wf_count==@highest_count_across_lines)
        @highest_count_words_across_lines.push(obj)
      end
    end
  end
  def print_highest_word_frequency_across_lines()
    #Imprimo los mensajes segun el formato README
    puts "Las siguientes palabras tienen la frecuencia mas alta de palabras por linea:"
    @highest_count_words_across_lines.each do |obj|
      puts "#{obj.highest_wf_words} aparece en la linea #{obj.line_number}"
    end
  end
end