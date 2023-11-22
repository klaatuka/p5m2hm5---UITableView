

import UIKit

class ViewController: UIViewController {
    
    let item = ["Текст ячейки 0","Текст ячейки 1","Текст ячейки 2","Текст ячейки 3"]
    let item2 = ["Машка Бумашка","Василий Петрович","Жанка Вырвиглаз"]
    let images = ["photo-1", "photo-2", "photo-3", "photo-4"]
    
    //экшн кнопки которая в ячейках во 2-ой секции под индексом 1
    lazy var actionBtn = UIAction { _ in
        print(111)
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return item.count
        case 1:
            return item2.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.imageView?.clipsToBounds = true
        cell.imageView?.contentMode = .scaleAspectFill
        cell.textLabel?.font = .systemFont(ofSize: 16)
        switch indexPath.section {
        case 0:
            cell.imageView?.layer.cornerRadius = 10
            cell.imageView?.image = UIImage(named: "\(images[indexPath.row])")
            cell.textLabel?.text = "\(item[indexPath.row])"
            //констрейнты для фото
            if let imageView = cell.imageView, let textLabel = cell.textLabel {
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 7).isActive = true
                imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 12).isActive = true
                imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -7).isActive = true
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
                //констрейнты для текста
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 13).isActive = true
                textLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
            }
        case 1:
            cell.imageView?.layer.cornerRadius = 45 // тут у меня не получается формулой высчитывать
            cell.imageView?.image = UIImage(named: "\(images[indexPath.row])")
            cell.textLabel?.text = "\(item2[indexPath.row])"
            
            //кнопка - написать
            var btnPr = UIButton(type: .system)
            btnPr = UIButton(primaryAction: actionBtn)
            btnPr.setTitle("написать", for: .normal)
            cell.contentView.addSubview(btnPr)
            btnPr.translatesAutoresizingMaskIntoConstraints = false
            btnPr.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16).isActive = true
            btnPr.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
            //констрейнты для фото
            if let imageView = cell.imageView, let textLabel = cell.textLabel {
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15).isActive = true
                imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 11).isActive = true
                imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -11).isActive = true
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
                //констрейнты для текста
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
                textLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
            }
        default:
            return cell
        }
        return cell
    }
    //регулирует высоту ячеек как всей секции, так и конкретной ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 110
        }
        return 60
    }
    //делегат на касание ячеек в данном случае печатает содержимок
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print(item[indexPath.row])
        }
        
        if indexPath.section == 1 {
            print(item2[indexPath.row])
        }
    }
}

