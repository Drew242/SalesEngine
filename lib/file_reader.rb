
class FileReader
  def read(file)
    CSV.open "#{file}", headers: true, header_converters: :symbol
  end
end
