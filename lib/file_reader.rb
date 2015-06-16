
class FileReader
  def read(file)
    content = CSV.open "#{file}", headers: true, header_converters: :symbol
  end
end
