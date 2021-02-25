import Types "./types";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Option "mo:base/Option";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

module {
    type NewJob = Types.NewJob;
    type Job = Types.Job;
    type UserId = Types.UserId;

    public class Directory() {
        // ?
        let hashMap = HashMap.HashMap<UserId, Job>(2, isEq, Principal.hash);

        public func createOne(userId: UserId, job: NewJob) {
            hashMap.put(userId, makeJob(userId, job));
        };

        public func findOne(userId: UserId): ?Job {
            hashMap.get(userId)
        };

        public func updateOne(userId: UserId, job: Job) {
            hashMap.put(userId, job);
        };

        public func findMany(userIds: [UserId]): [Job] {
            func getJob(userId: UserId): Job {
                Option.unwrap<Job>(hashMap.get(userId))
            };
            Array.map<UserId, Job>(userIds, getJob)
        };

        public func findBy(term: Text): [Job] {
            var jobs: [Job] = [];
            for ((id, job) in hashMap.entries()) {
                // ?
                let all = job.title # " " # job.company # " " # job.description # " " # job.location;
                if (includesText(all, term)) {
                    jobs := Array.append<Job>(jobs, [job]);
                };
            };
            jobs
        };

        // 
        func makeJob(userId: UserId, job: NewJob): Job {
            {
                id = userId;
                title = job.title;
                company = job.company;
                location = job.location;
                tag = job.tag;
                description = job.description;
                salary = job.salary;
                email = job.email;
            }
        };

        func includesText(string: Text, term: Text): Bool {
            let stringArray = Iter.toArray<Char>(string.chars());
            let termArray = Iter.toArray<Char>(term.chars());

            var i = 0;
            var j = 0;

            while (i < stringArray.size() and j < termArray.size()) {
                if (stringArray[i] == termArray[j]) {
                i += 1;
                j += 1;
                if (j == termArray.size()) { return true; }
                } else {
                i += 1;
                j := 0;
                }
            };
            false
        };
        
    };

    func isEq(x: UserId, y: UserId): Bool { x == y };
};