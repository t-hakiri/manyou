10.times do |i| 
  Task.create (
              title: "test"+ i
              content: "content"+ i
              deadline: Date.now + i 
              status: 
              )