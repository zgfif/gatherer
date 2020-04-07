export class Project {
  constructor() {
    this.tasks = []
  }

  appendTask(task) {
    this.tasks.push(task)
    task.project = this
    task.index = this.tasks.length - 1
  }

  firstTask() {
    return this.tasks[0]
  }

  lastTask() {
    return this.tasks[this.tasks.length - 1]
  }

  swapTasksAt(index1, index2) {
    const temp = this.tasks[index1]
    this.tasks[index1] = this.tasks[index2]
    this.tasks[index2] = temp
  }
}

export class Task {
  constructor(name, size) {
    this.name = name
    this.size = size
    this.project = null
    this.index = null
  }

  isFirst() {
    if (this.project) {
      return this.project.firstTask() === this
    }
    return false
  }

  isLast() {
    if (this.project) {
      return this.project.lastTask() === this
    }
    return false
  }

  moveUp() {
    if (this.isFirst()) {
      return
    }
    this.project.swapTasksAt(this.index - 1, this.index)
  }

  moveDown() {
    if (this.isLast()) {
      return
    }
    this.project.swapTasksAt(this.index, this.index + 1)
  }
}

// class Task {
//   static swapTasks(first, second) {
//     second.detach()
//     second.insertBefore(first)
//   }
//
//   constructor(anchor) {
//     this.$anchor = $(anchor)
//     this.$rowElement = this.$anchor.parents("tr")
//   }
//
//   previous() {
//     return $(this.$rowElement.prev())
//   }
//
//   next() {
//     return $(this.$rowElement.next())
//   }
//
//   onUpClick() {
//     if (this.previous().length === 0) {
//       return
//     }
//     Task.swapTasks(this.previous(), this.$rowElement)
//     this.updateServer("up")
//   }
//
//   onDownClick() {
//     if (this.next().length === 0) {
//       return
//     }
//     Task.swapTasks(this.$rowElement, this.next())
//     this.updateServer("down")
//   }
//
//   taskId() {
//     return this.$rowElement.data("taskId")
//   }
//
//   updateServer(upOrDown) {
//     const url = `/tasks/${this.taskId()}/${upOrDown}.json`
//     $.ajax({
//       url,
//       beforeSend: xhr => {
//         xhr.setRequestHeader(
//           "X-CSRF-Token",
//           $('meta[name="csrf-token"]').attr("content")
//         )
//       },
//       data: { _method: "PATCH" },
//       type: "POST"
//     })
//   }
// }
//
// $(() => {
//   $(document).on("click", ".up-button", event => {
//     new Task(event.target).onUpClick()
//   })
//
//   $(document).on("click", ".down-button", event => {
//     new Task(event.target).onDownClick()
//   })
// })
