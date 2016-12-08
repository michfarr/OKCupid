OKCupid Matching
================
    input.json
| Name              | Type    | Ref                                                                   |
|-------------------|---------|-----------------------------------------------------------------------|
|                   | hash    | data                                                                  |
| profiles          | array   | data['profiles']                                                      |
|                   | hash    | data['profiles'][index]                                               |
| id                | integer | data['profiles'][index]['id']                                         |
| answers           | array   | data['profiles'][index]['answers']                                    |
|                   | hash    | data['profiles'][index]['answers'][index]                             |
| questionId        | integer | data['profiles'][index]['answers'][index]['questionId']               |
| answer            | integer | data['profiles'][index]['answers'][index]['answer']                   |
| acceptableAnswers | array   | data['profiles'][index]['answers'][index]['acceptableAnswers']        |
|                   | integer | data['profiles'][index]['answers'][index]['acceptableAnswers'][index] |
| importance        | integer | data['profiles'][index]['answers'][index]['importance']               |
```javascript
// result.json
{
  results: [
    {
      profileId: Int,
      matches: [
        {
          profileId: Int,
          score: 0 > Float > -1
        },
        {
          ...profileId
          ...score
        }
      ]
    },
    {
      ...profileId:
      ...matches:
    }
  ]
}
```
#### Value Range
    importance: 0, 4
#### Compare
    For     profile.id as A & profile.otherId as B
    Where   A.questionId    =    B.questionId
| A                 | B                 |
|-------------------|-------------------|
| answer            | answer            |
| acceptableAnswers | acceptableAnswers |
| importance        | importance        |
***
#### Score
    points_possible = sum( IMPORTANCE_POINTS[importance] )

      sum all importance points for all intersecting questions
      where importance is used as the index of IMPORTANCE_POINTS

    points_earned = if(answer == acceptableAnswers)-> sum( IMPORTANCE_POINTS[importance] )

      where the answer of user A matches the acceptableAnswers of user B
      sum all IMPORTANCE_POINTS with importance used as the index

    satisfaction = points_earned / points_possible

      returns user B's satisfaction score for user A's answers

    match_score = sqrt( satisfactionA * satisfactionB )

      satisfaction(?A:B) being each user's satisfaction for the other.
